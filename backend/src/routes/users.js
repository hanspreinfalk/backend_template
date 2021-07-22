const { Router } = require('express');
const router = Router();

const User = require('../models/User');

const faker = require('faker');

router.get('/api/users', async (req, res) => {
    const users = await User.find();
    res.json({users});
    
    req.append('Access-Control-Allow-Origin', '*');
    // res.append('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    // res.append('Access-Control-Allow-Headers', 'Content-Type');
    // res.append('Content-Type: application/json');	// CORS
    req.append("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
});

router.get('/api/users/create', async (req, res) => {
    for (let i = 0; i < 5; i++) {
        await User.create({
            firstName: faker.name.firstName(),
            lastName: faker.name.lastName(),
            avatar: faker.image.avatar()
        });
    }
    res.json({message: '5 Users created'});
});

module.exports = router;