

# Configure steelbooks

```shell
upstream steelbooks {
  server test_steelbooksatbestbuy_website:8000 fail_timeout=0;
}
`test_steelbooksatbestbuy_website -> key associated with website container in the docker-compose.yml`
`8000 -> port the app is running on`
```