import express from "express";
import cors from "cors";
import mysql from "mysql2/promise";


const pool = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "senai",
  database: "bibliofile"
});

const app = express();
app.use(express.json());
app.use(cors());