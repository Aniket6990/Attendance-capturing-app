const mongoose = require('mongoose')
const bcrypt = require('bcrypt');
// userSchema
const Schema =  mongoose.Schema({
    fname: {
        type: String,
        min:3,
    },
    lname:{
        type: String,
        min:3,
    },
    email: {
        type: String,
        unique: true,
    },
    hash_password: {
        type: String,
        min:6,
    },
    registrationNumber: {
        type: String
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
    contactNumber:{
        type: Number,
        min:10,
    },
    gender: {
        type: String,
        required: true,
    }
},{ timestamps: true });


Schema.virtual('password').set(function(password){
    this.hash_password = bcrypt.hashSync(password,10);
});

Schema.virtual('fullName').get(
    function(){
        return `${this.fname} ${this.lname}`;
    }
)

Schema.methods = {
    authenticate: function(password){
        return bcrypt.compareSync(password,this.hash_password);
    }
}

module.exports = mongoose.model("employee",Schema);