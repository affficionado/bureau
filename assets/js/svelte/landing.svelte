<script>
  let url = "";
  const arxiv_id_pattern = /([a-zA-Z\-]+(?:\.[a-zA-Z]{2})?\/\d{7}|\d+\.\d+)([vV]\d+)?/;
  const arxiv_url_pattern = new RegExp(`(?:https:\/\/)?arxiv.org\/[^\/]+\/(${arxiv_id_pattern.source})(\.pdf)?`);
</script>

<style>
  .center-fit {
    max-width: 100%;
    max-height: 100vh;
  }
</style>

<div class="columns is-vcentered is-gapless">

  <div class="column is-half is-flex is-justify-content-end">
    <img class="center-fit" src="images/ida.png" alt="Ida standing at the desk">
  </div>

  <div class="column is-half ml-6">
    <div class="is-size-4 mb-2">
      Read scientific papers at the <span class="has-text-weight-light">Bureau</span>
    </div>

    <form action="/papers" method="get">
      <div class="field has-addons">
        <div class="control">
          <input type="url" name="url" placeholder="arxiv paper URL" pattern={arxiv_url_pattern.source} bind:value={url} class="input is-align-self-center">
        </div>
        <div class="control">
          <button class="button is-primary">convert to HTML</button>
        </div>
      </div>
      <p class="help">
        e.g. https://arxiv.org/pdf/2105.03236.pdf
      </p>
    </form>

  </div>
</div>
