<script>
  import { onMount } from 'svelte';

  export let arxiv_pdf_url;
  export let strat = [
    ["title", "abs", "intro", "section", "subsection", "outro", "ref"],
    ["figure", "math"],
  ];

  let activePhase = "full";
  let activeElement = 0;
  let article;
  let sections;
  let phaseElements = new Array(strat.length);

  onMount(() => {
    article = document.querySelector("article");
    sections = article.querySelectorAll(".ltx_section");

    for (const [i, filters] of strat.entries()) {
      const selector = filters.map(f => entity_to_selector(f)).join(",");
      phaseElements[i] = Array.from(article.querySelectorAll(selector));
    }
  });

  function entity_to_selector(name) {
    switch(name) {
      case "title": return "h1"; break
      case "abs": return ".ltx_abstract"; break;
      case "intro": return "#S1"; break;
      case "section": return ".ltx_title_section"; break;
      case "subsection": return ".ltx_title_subsection"; break;
      case "math": return ".ltx_DisplayMath"; break;
      case "outro": return `#${find_conclusion()}`; break;
      case "ref": return "#bib"; break;
      case "figure": return ".ltx_figure"; break;
    }
  }

  function find_conclusion() {
    return sections[sections.length - 1].id;
  }

  function hide_all() {
    activePhase = "hide";
    article.classList.add("bureau-hide");
  }

  function show_all() {
    if (activePhase == "full") return;

    article.classList.remove("bureau-hide");
    if (activePhase != "hide")
      phaseElements[activePhase].forEach(s => s.classList.remove("bureau-unhide"));
    activePhase = "full";
  }

  function set_phase(phase) { 
    if (activePhase == phase) return;

    hide_all();
    activePhase = phase;
    phaseElements[activePhase].forEach(
      e => e.classList.add("bureau-unhide")
    );
    set_element(0);
  }

  function set_element(index) {
    activeElement = index;
    console.log(phaseElements[activePhase][index]);
    phaseElements[activePhase][index].scrollIntoView();
  }

  function prev_element() {
    set_element(Math.max(0, activeElement - 1));
  }

  function next_element() {
    set_element(Math.min(phaseElements[activePhase].length - 1, activeElement + 1));
  }

  function handleKeydown(event) {
    if (activePhase == "full" || activePhase == "hide") return;

    switch(event.keyCode) {
      case 78: // n
        next_element();
        break;
      case 80: // p
        prev_element();
        break
    }
  }
</script>

<style>
  .navbar-end .button {
    margin: auto 0.25em;
  }
</style>

<svelte:window on:keydown={handleKeydown}/>

<div class="navbar-end">
  {#each strat as phase, i}
    <button class="button navbar-item is-light"
      class:is-active="{activePhase == i}"
      on:click={() => set_phase(i)}>
      {i + 1}
    </button>
  {/each}

  <button class="button navbar-item is-light" 
    on:click={() => hide_all()}>
    Hide all
  </button>

  <button class="button navbar-item is-light" 
    class:is-active="{activePhase == "full"}"
    on:click={() => show_all()}>
    Full text
  </button>

  <a href={arxiv_pdf_url} class="navbar-item">PDF</a>
</div>
