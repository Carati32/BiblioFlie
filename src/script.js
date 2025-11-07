const botao = document.getElementById("btnMostrarForm");
const form = document.getElementById("formLeitura");
const cancelar = document.querySelector(".btn-cancelar");
const btnCriar = document.getElementById("btnCriar");
const containerLivros = document.querySelector(".livros");

botao.addEventListener("click", () => {
    form.classList.remove("hidden");
});

cancelar.addEventListener("click", (e) => {
    e.preventDefault(); 
    form.classList.add("hidden");
});

btnCriar.addEventListener("click", (e) => {
    e.preventDefault();

    const titulo = document.getElementById("titulo").value.trim();
    const genero = document.getElementById("genero").value; 
    const nota = document.getElementById("nota").value; 
    
    const novoLivroData = {
        titulo: titulo || "Livro Sem Título",
        autor: document.getElementById("nome").value.trim() || "Desconhecido",
        genero: genero,
        nota: nota === "Selecione uma nota" ? "-" : nota,
        total_pagina: Number(document.getElementById("paginas").value) || "-"
    };

    criarCard(novoLivroData);
    form.classList.add("hidden");
    form.reset(); 
});

function criarCard(data) {
    const card = document.createElement("div");
    card.classList.add("livro-card");
    
    card.setAttribute('data-genero', data.genero.toLowerCase().replace(/\s/g, '-'));
    card.setAttribute('data-nota', String(data.nota));

    card.innerHTML = `
        <div class="capa">Capa do Livro</div>
        <h4>${data.titulo}</h4>
        <p>${data.autor}</p>
        <p>⭐ ${data.nota}</p>
        <p>${data.genero} • ${data.total_pagina} págs</p>
        <button>Recomendar</button>
    `;

    containerLivros.prepend(card);
}



const selectGeneroFiltro = document.getElementById('filtro-genero');
const selectNotaFiltro = document.getElementById('filtro-nota');
const btnAplicarFiltros = document.getElementById('btn-aplicar-filtros');

btnAplicarFiltros.addEventListener('click', aplicarFiltrosVisuais);

function aplicarFiltrosVisuais() {
    const generoSelecionado = selectGeneroFiltro.value;
    const notaSelecionada = selectNotaFiltro.value;

    const todosOsCards = document.querySelectorAll('.livro-card');

    todosOsCards.forEach(card => {
        const generoDoLivro = card.getAttribute('data-genero');
        const notaDoLivro = card.getAttribute('data-nota');

        let mostrarCard = true;

        if (generoSelecionado !== 'todos' && generoDoLivro !== generoSelecionado) {
            mostrarCard = false;
        }

        if (notaSelecionada !== 'todas' && notaDoLivro !== notaSelecionada) {
            mostrarCard = false;
        }

        if (mostrarCard) {
            card.style.display = ''; 
        } else {
            card.style.display = 'none'; 
        }
    });
}
