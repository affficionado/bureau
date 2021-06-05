<script>
  export let id;
  export let title;
  export let arxiv_pdf_url;
</script>

<style>
</style>

<p class="box has-text-centered">
  Conversion for <i>"{title}"</i> from LaTeX to HTML has failed.
  <br>
  Take a look at <a href={`http://localhost:9000/status/${id}`}>logs</a>
  or original <a href={arxiv_pdf_url}>PDF</a>.
</p>
