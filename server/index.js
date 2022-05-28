const express = require('express');
const mongoose = require('mongoose');
const app = express()
const dotenv = require('dotenv');
const bodyParser = require('body-parser')
dotenv.config({path:'./.env'});
app.use(bodyParser.json());
//routes
const AccountCreate = require('./routes/employeeroute');
const adminRoute = require('./routes/adminroute');

//middlewares
app.use('/api',AccountCreate);
app.use('/api',adminRoute);

mongoose.connect(process.env.DBURL).then(()=>{
    console.log("connected to database")
}).catch((err)=>{
    console.log(`error occurred:${err}`);
})


app.listen(process.env.PORT,()=>{
    console.log(`server is running on port:${process.env.PORT}`);
})
