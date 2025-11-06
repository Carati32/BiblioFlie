import express from "express"
import cors from "cors"
import mysql from "mysql2/promise"

const pool = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "senai",
  database: "bibliofile"
})

const app = express()
app.use(express.json())
app.use(cors())

app.get("/", (req, res) => {
  res.send("API Bibliofile funcionando")
})

app.post("/registrar", async (req, res) => {
  try {
    const {
      usuario_id,
      titulo,
      autor,
      genero,
      total_pagina,
      tempo_leitura_hora,
      nota,
      resenha
    } = req.body;

    const [results] = await pool.query(
      "INSERT INTO leitura (usuario_id, titulo, autor, genero, total_pagina, tempo_leitura_hora, nota, resenha) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)",
      [usuario_id, titulo, autor, genero, total_pagina, tempo_leitura_hora, nota, resenha]
    );

    const [leituraCriada] = await pool.query(
      "SELECT * FROM leitura WHERE id = ?",
      [results.insertId]
    );

    console.log("TESTE DEBUG: Retornando este objeto:", leituraCriada[0]);
    return res.status(201).json(leituraCriada[0]);
  } catch (error) {
    console.error("Erro no cadastro:", error);
    return res.status(500).json({ message: "Erro interno no servidor." });
  }
});


app.listen(3000, () => console.log("API rodando na porta 3000"))
