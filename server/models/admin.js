const mongoose = require('mongoose')
const bcrypt = require('bcrypt')

const adminSchema = new mongoose.Schema({
    fname: {
        type: String,
        required: true
    },
    lname: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    hash_password: {
        type: String
    },
    registrationNumber: {
        type: String,
        unique: true
    },
    dob: {
        type: String
    },
    joiningYear: {
        type: String
    },
    avatar: {
        type: String
    },
    contactNumber: {
        type: Number
    },
    gender: {
        type: String,
        required: true,
    }
}, { strict: false })

adminSchema.virtual('password').set(function(password){
    this.hash_password = bcrypt.hashSync(password,10);
});

adminSchema.virtual('fullName').get(
    function(){
        return `${this.fname} ${this.lname}`;
    }
)

adminSchema.methods = {
    authenticate: function(password){
        return bcrypt.compareSync(password,this.hash_password);
    }
}

module.exports = mongoose.model('admin', adminSchema)
