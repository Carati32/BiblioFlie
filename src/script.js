const botao = document.getElementById("btnMostrarForm");
const form = document.getElementById("formLeitura");
const cancelar = document.querySelector(".btn-cancelar");
const btnCriar = document.getElementById("btnCriar");


botao.addEventListener("click", () => {
    form.classList.remove("hidden");
});


cancelar.addEventListener("click", (e) => {
    e.preventDefault();
    form.classList.add("hidden");
});


btnCriar.addEventListener("click", async (e) => {
    e.preventDefault();

    const titulo = document.getElementById("titulo").value.trim();
    const autor = document.getElementById("nome").value.trim();
    const genero = document.getElementById("genero").value.trim();
    const total_pagina = Number(document.getElementById("paginas").value) || 0;
    const tempo_leitura_hora = Number(document.getElementById("tempo").value) || 0;
    const nota = Number(document.getElementById("nota").value) || 0;
    const resenha = document.getElementById("resenha").value.trim();

    const livro = {
        usuario_id: 1,
        titulo,
        autor,
        genero,
        total_pagina,
        tempo_leitura_hora,
        nota,
        resenha
    }

    console.log("Livro a ser enviado:", livro);

    const data = await criarLeitura(livro);

    if (!data) {
        console.log("Falha ao criar");
        return;
    }

    criarCard(data);
    form.classList.add("hidden");
});


async function criarLeitura(livro) {
    try {
        const response = await fetch("http://localhost:3000/registrar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(livro),
        });

        const data = await response.json();
        console.log("Retorno da API:", data);

        if (response.ok) {
            return data;
        }

        return null;

    } catch (error) {
        console.error("Erro ao registrar o livro:", error);
        return null;
    }
}



function criarCard(data) {
    const container = document.querySelector(".livros");
    if (!container) {
        console.error("ERRO: container não existe!");
        return;
    }

    const card = document.createElement("div");
    card.classList.add("livro-card");

    card.innerHTML = `
        <div class="capa">Capa do Livro</div>
        <h4>${data.titulo ?? "(Sem título)"}</h4>
        <p>${data.autor ?? "Desconhecido"}</p>
        <p>⭐ ${data.nota ?? "-"}</p>
        <p>${data.genero ?? "-"} • ${data.total_pagina ?? "-"} págs</p>
        <button>Recomendar</button>
    `;

    container.prepend(card);
}
