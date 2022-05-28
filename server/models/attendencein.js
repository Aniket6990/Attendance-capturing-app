const mongoose = require('mongoose')
const AttendenceSchema = mongoose.Schema({
    employee: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'userschema'
    },
    checkin: {
        type: String,
    },
    checkout:{
        type: String,
    },
    locationin: {
        type: String,
    },
    locationout: {
        type: String,
    }
})

module.exports = mongoose.model('attendencein',AttendenceSchema);