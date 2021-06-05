<script>
  export let toc;
</script>

<style>
  nav {
    display: inline flow-root;
    position: fixed;
    max-height: 100vh;
    max-width: 16%;
    top: 3.25rem;
    bottom: 0;
    overflow-y: auto;
    word-wrap: break-word;
  }
</style>

<nav class="menu menu-list has-background-white-ter">
  {@html toc}
</nav>
