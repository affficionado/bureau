<script>
  import Header from "./header.svelte";
  import Toc from "./toc.svelte";
  
  export let id;
  export let toc;
  export let body;
  export let arxiv_pdf_url;
</script>

<Header {id} status="success" {toc} {arxiv_pdf_url}/>
<main role="main" class="columns">
  <div class="column is-2">
    <Toc {toc}/>
  </div>
  <div class="column is-8">
    {@html body}
  </div>
  <div class="column is-2"></div>
</main>
