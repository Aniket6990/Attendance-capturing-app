const express = require('express')
const {login, attendenceIn, attendenceOut} = require('../controllers/employeecontroller');
const router = express.Router();

router.post('/login',login)
router.post('/attendencein',attendenceIn);
router.post('/attendenceout',attendenceOut);

module.exports = router;