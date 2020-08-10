## Configuração certificado localhost.dev e traefik:

### Gerar o certificado:
`mkcert --cert-file localhost.crt --key-file localhost.key localhost 127.0.0.1 ::1 local.dev "*.local.dev"`

### Instalar dnsmasq:
`dnfi dnsmasq`

### Configurar dnsmasq

Editar o arquivo `/etc/NetworkManager/dnsmasq.d/localhost.dev.conf` e acrescentar:

`address=/local.dev/127.0.0.1`

Se estiver com problema na `porta 53`, execute o seguinte comando para ver o que está escutando:

`sudo ss -lp "sport = :domain"`

Se for o `systemd-resolved`, editar o arquivo `/etc/systemd/resolved.conf` e adicionar ou editar a linha:

`DNSStubListener=no`

Não esqueça de reiniciar:

`sudo systemctl restart systemd-resolved`

### Configurar NetworkManager

Editar o arquivo `/etc/NetworkManager/conf.d/dnsmasq.conf` (criar caso não exista) e adicione:

```
[main]
dns=dnsmasq
```

### No caso de usar PIHOLE (em dúvida sobre isso ainda):
Editar o arquivo `/etc/dnsmasq.conf` e adicionar:

```
server=192.168.100.7
```

*Onde 192.168.100.7* é o endereço de IP do PIHOLE.


### Reiniciar serviços:

`sudo systemctl restart dnsmasq NetworkManager`

---

#### Links úteis:

https://brunopaz.dev/blog/setup-a-local-dns-server-for-your-projects-on-linux-with-dnsmasq

# Trabalhando com a API

### Adicionar mais um host

```
curl -X POST -H \
  "Content-Type: application/json" \
  -d '["smt.local.dev", "smt1.local.dev"]' \
  "http://localhost:2019/config/apps/http/servers/srv0/routes/0/match/0/host/..."
```

### Carregar as configurações atuais

`curl localhost:2019/config/ | jq`


