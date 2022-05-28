const User = require('../models/userschema');
const Attendence = require('../models/attendencein');

var curentuser;
exports.login = (req,res) =>{
    User.findOne({registrationNumber: req.body.registrationNumber}).exec((err,user)=>{
        if(err){
            return res.status(400).json({message:"registration number id don't exist"});
        }
        if(user){
            if(user.authenticate(req.body.password)){
                const {_id,fname,lname,registrationNumber,fullName,email,dob,contactNumber} = user;
                res.status(201).json({
                    user:{
                        _id,fname,lname,registrationNumber,fullName,email,dob,contactNumber
                    }
                })
                curentuser = registrationNumber;
            }else{
                res.status(400).json({
                    message:"invalid username or password"
                })
            }
        }else{
            return res.status(400).json({
                message: "something went wrong"
            })
        }
    })
}

exports.attendenceIn = async (req,res)=>{
   try {
    const {locationin} = req.body;
    var d = new Date();
    var checkin = (d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()).toString();
        const attendencein = new Attendence({locationin,checkin});
        await attendencein.save((err,data)=>{
            if(err){
                return res.status(400).json({error:"error while checking in"})
            }
            if(data){
                return res.status(201).json({result: attendencein});
            }
        });
   } catch (error) {
       console.log(error) 
   }
}
exports.attendenceOut = async (req,res)=>{
    try {
     const {locationout} = req.body;
     var d = new Date();
     var checkout = (d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()).toString();
         const attendenceout = Attendence.findOneAndUpdate({locationout,checkout}).then(()=>{
             res.status(201).json({message:"done"});
         }).catch((err)=>{
             console.log(err)
         })
    } catch (error) {
        console.log(error)
    }
 }