const express = require('express')
const router = express.Router()

const {addAdmin,adminlogin, addemployee, getAllEmployees} = require('../controllers/admincontroller');

router.post('/adminlogin', adminlogin)
router.post('/addAdmin', addAdmin )
router.post('/addemployee',addemployee)
router.get('/employees',getAllEmployees)
module.exports = router