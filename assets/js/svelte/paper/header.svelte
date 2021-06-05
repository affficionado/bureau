<script>
  import Toc from "./toc.svelte";
  import Controls from "./controls.svelte";

  export let id;
  export let toc;
  export let status;
  export let arxiv_pdf_url;
</script>

<style>
  header {
    border-bottom: 1px solid hsl(0, 0%, 86%);
  }
</style>

<div class="hero-head">
  <header class="navbar is-light is-fixed-top">
    <div class="container">
      <div class="navbar-brand has-text-weight-light">
        <a href="http://localhost:9001/" class="navbar-item">
          Bureau
        </a>
        {#if status == "success"}
          <span class="navbar-burger" data-target="navbarMenuHeroC">
            <span></span>
            <span></span>
            <span></span>
          </span>
        {/if}
      </div>
      <div id="navbarMenuHeroC" class="navbar-menu">
        {#if status == "success"}
          <Controls {arxiv_pdf_url} />
        {/if}
      </div>
    </div>
  </header>
</div>
