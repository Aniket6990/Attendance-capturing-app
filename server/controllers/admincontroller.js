const Admin = require('../models/admin');
const Employee = require('../models/userschema');
const Validator = require('validator')

exports.addAdmin = (req,res)=>{
        const {fname,lname,email,password,contactNumber,dob,gender} = req.body;
        if (!fname || !lname || !email || !dob || !password || !contactNumber || !gender){
            return res.status(400).json({success:false, message:"pls fill all fields properly"})
        }

        Admin.findOne({email:email}).exec((err,admin)=>{
            admin && res.status(400).json({message:"email already exist"});
        })
        const d = new Date();
        const joiningYear = d.getFullYear();
        var components = [
            "ADM",
            joiningYear,
            fname
        ];
        var registrationNumber = components.join("");
        const newAdmin = new Admin({
            fname,lname,email,password,contactNumber,dob,joiningYear,registrationNumber,gender
        })
        newAdmin.save((err,data)=>{
            if(err){
                return res.status(400).json({error:"something went wrong"})
            }
            if(data){
                return res.status(200).json({message:"Admin added successfully"})
            }
        })
}

exports.adminlogin = async (req,res)=>{
    if (!Validator.isLength(req.body.registrationNumber, { min: 8, max: 15 })) {
        return res.status(400).json({error:"Registration Number must be minimum of 8 characters"})
    }

    if (Validator.isEmpty(req.body.registrationNumber)) {
        return res.status(400).json({error:"Registration Number field is required"})
    }
    if (Validator.isEmpty(req.body.password)) {
        return res.status(400).json({error:"Password field is required"})
    }
    Admin.findOne({registrationNumber: req.body.registrationNumber}).exec((err,admin)=>{
        if(err){
            return res.status(400).json({message:"registration Number don't exist"});
        }
        if(admin){
            if(admin.authenticate(req.body.password)){
                const {_id,fname,lname,registrationNumber,fullName,email,dob,contactNumber,gender} = admin;
                res.status(201).json({
                    user:{
                        _id,fname,lname,registrationNumber,fullName,email,dob,contactNumber,gender
                    }
                })
            }else{
                res.status(400).json({
                    message:"invalid Registration Number or password"
                })
            }
        }else{
            return res.status(400).json({
                message: "something went wrong"
            })
        }
    })

}

exports.addemployee = async (req,res)=>{
    const {fname,lname,dob,email,password,contactNumber,gender} = req.body;
    
    if(!fname || !lname || !dob || !email || !password || !contactNumber || !gender){
        return res.status(422).json({error:"pls fill all fields properly"});
    }

        Employee.findOne({email:email}).exec((err,employee)=>{
            employee && res.status(400).json({message:"email already exist"});
        })

        const d = new Date();
        const joiningYear = d.getFullYear();
        var components = [
            "EMP",
            joiningYear,
            fname
        ];
        var registrationNumber = components.join("");

        const createUser =  new Employee({fname,lname,registrationNumber,email,password,contactNumber,joiningYear,dob,gender});


        await createUser.save((err,data)=>{
            if(err){
                console.log(err)
            }
            if(data){
                return res.status(200).json({message:"user created successfully"});
            }
        });
}

exports.getAllEmployees = async (req,res)=>{
    try {
        const employees = await Employee.find({})
    if(Employee.length===0){
        return res.status(404).json({message:"No Employee found"})
    }
    res.status(200).json({result: employees})
    } catch (error) {
        res.status(400).json({message:`error in getting all employees,${error.messagr}`})
    }
}