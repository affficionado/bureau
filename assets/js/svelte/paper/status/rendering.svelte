<script>
  import socket from "../../../app.js";
  export let id;
  export let title;
  export let arxiv_pdf_url;

  const channel = socket.channel(`render:${id}`, {});
  channel.join()
    .receive("ok", resp => { console.log("joined succesfully", resp) })
    .receive("error", resp => { console.log("unable to join", resp) });

  channel.on("render_finish", payload => {
    location.reload();
  });
</script>

<p class="box has-text-centered">
  Sisyphe is rendering <i>"{title}"</i> right now!
  <br>
  Page will reload automaticlly once it is finished.
  <br>
  In a meantime, you might take a look at ugly <a href={arxiv_pdf_url}>PDF</a> instead.
</p>
