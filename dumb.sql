CREATE DATABASE bibliofile;
USE bibliofile;

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_perfil VARCHAR(50) DEFAULT 'Leitora ávida',
    livro_lido INT DEFAULT 0,
    media_nota DECIMAL(2,1) DEFAULT 0.0,
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(255)
);

CREATE TABLE genero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE livro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    genero_id INT,
    total_pagina INT,
    capa_url VARCHAR(255),
    FOREIGN KEY (genero_id) REFERENCES genero(id)
);

CREATE TABLE leitura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    livro_id INT,
    titulo VARCHAR(150),
    autor VARCHAR(100),
    genero VARCHAR(50),
    total_pagina INT,
    tempo_leitura_hora INT,
    nota TINYINT CHECK (nota BETWEEN 1 AND 10),
    resenha TEXT,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (livro_id) REFERENCES livro(id)
);


CREATE TABLE recomendacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    livro_id INT NOT NULL,
    comentario VARCHAR(255),
    data_recomendacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (livro_id) REFERENCES livro(id)
);

CREATE TABLE discussao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    livro_id INT NOT NULL,
    mensagem TEXT NOT NULL,
    data_postagem TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (livro_id) REFERENCES livro(id)
);


SELECT * FROM discussao;

INSERT INTO usuario (nome, tipo_perfil, livro_lido, media_nota, email, senha)
VALUES
('Maria Silva', 'Leitora ávida', 47, 4.2, 'maria@email.com', 'hash123'),
('João Pereira', 'Leitor casual', 12, 3.8, 'joao@email.com', 'hash456'),
('Ana Costa', 'Exploradora literária', 22, 4.5, 'ana@email.com', 'hash789'),
('Lucas Souza', 'Amante de clássicos', 34, 4.6, 'lucas@email.com', 'hash321'),
('Clara Ramos', 'Leitora noturna', 18, 4.0, 'clara@email.com', 'hash654'),
('Ricardo Melo', 'Colecionador de histórias', 56, 4.8, 'ricardo@email.com', 'hash987'),
('Beatriz Lima', 'Jovem sonhadora', 9, 4.3, 'bia@email.com', 'hashabc'),
('Fernando Rocha', 'Leitor técnico', 20, 4.1, 'fernando@email.com', 'hashdef'),
('Laura Martins', 'Romântica incurável', 40, 4.9, 'laura@email.com', 'hashghi'),
('Paulo Henrique', 'Fã de ficção', 15, 4.4, 'paulo@email.com', 'hashjkl');

INSERT INTO genero (nome)
VALUES
('Fantasia'),
('Romance'),
('Ficção Científica'),
('Terror'),
('Mistério'),
('Aventura'),
('Biografia'),
('História'),
('Drama'),
('Poesia');

INSERT INTO livro (titulo, autor, genero_id, total_pagina, capa_url)
VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1, 1216, 'capa_senhor_aneis.jpg'),
('Orgulho e Preconceito', 'Jane Austen', 2, 432, 'capa_orgulho_preconceito.jpg'),
('Duna', 'Frank Herbert', 3, 896, 'capa_duna.jpg'),
('It: A Coisa', 'Stephen King', 4, 1104, 'capa_it.jpg'),
('O Código Da Vinci', 'Dan Brown', 5, 689, 'capa_codigo_vinci.jpg'),
('As Aventuras de Sherlock Holmes', 'Arthur Conan Doyle', 6, 320, 'capa_sherlock.jpg'),
('Steve Jobs', 'Walter Isaacson', 7, 656, 'capa_steve_jobs.jpg'),
('Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 8, 592, 'capa_sapiens.jpg'),
('A Culpa é das Estrelas', 'John Green', 9, 288, 'capa_culpa_estrelas.jpg'),
('Os Lusíadas', 'Luís de Camões', 10, 256, 'capa_lusiadas.jpg');

INSERT INTO leitura (usuario_id, livro_id, titulo, autor, genero, total_pagina, tempo_leitura_hora, nota, resenha)
VALUES
(1, 1, 'O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia', 1216, 40, 10, 'Obra-prima da fantasia.'),
(2, 3, '1984', 'George Orwell', 'Distopia', 350, 12, 9, 'Reflexão profunda sobre controle social.'),
(1, 4, 'Dom Casmurro', 'Machado de Assis', 'Romance', 256, 8, 8, 'Narrativa intrigante e questionadora.'),
(3, 2, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Fábula', 96, 3, 10, 'Lindo e poético.'),
(2, 5, 'Orgulho e Preconceito', 'Jane Austen', 'Romance', 450, 15, 9, 'Excelente crítica social.'),
(3, 6, 'A Revolução dos Bichos', 'George Orwell', 'Satírico', 112, 4, 9, 'Curto, forte e direto.'),
(1, 7, 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Fantasia', 309, 10, 8, 'Divertido e mágico.'),
(4, 8, 'Inferno', 'Dan Brown', 'Suspense', 480, 14, 7, 'Instigante, cheio de enigmas.'),
(5, 9, 'It - A Coisa', 'Stephen King', 'Terror', 1100, 45, 9, 'Assustador e profundo.'),
(2, 10, 'Os Miseráveis', 'Victor Hugo', 'Drama', 1463, 60, 10, 'Magnífico e emocionate.');

INSERT INTO recomendacao (usuario_id, livro_id, comentario)
VALUES
(1, 1, 'Recomendo para quem ama fantasia épica!'),
(3, 2, 'Leitura obrigatória para fãs de romance.'),
(2, 3, 'Ficção científica de outro nível.'),
(6, 7, 'Biografia inspiradora.'),
(8, 8, 'Todo mundo deveria ler!'),
(5, 4, 'Perfeito para quem gosta de terror.'),
(9, 9, 'Romance emocionante.'),
(4, 5, 'Trama genial e cheia de reviravoltas.'),
(10, 6, 'Sherlock é sempre divertido.'),
(7, 10, 'Poesia clássica, leitura leve.');

INSERT INTO discussao (usuario_id, livro_id, mensagem)
VALUES
(1, 1, 'Quem mais se emocionou com a batalha final?'),
(3, 2, 'Mr. Darcy é um dos melhores personagens da literatura.'),
(2, 3, 'Achei difícil no começo, mas valeu a pena.'),
(5, 4, 'King sabe criar tensão como ninguém.'),
(4, 5, 'As pistas são muito bem amarradas.'),
(8, 8, 'Harari muda completamente nossa visão da história.'),
(9, 9, 'Chorei demais com esse livro.'),
(6, 7, 'Jobs era um gênio complexo.'),
(10, 6, 'Alguém recomenda outras histórias do Holmes?'),
(7, 10, 'Os Lusíadas são mais divertidos do que eu imaginava!');