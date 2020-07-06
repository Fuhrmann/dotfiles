# Configuração certificado localhost.dev e traefik:

### Gerar o certificado:
`mkcert --cert-file localhost.dev.crt --key-file localhost.dev.key localhost.dev "*.localhost.dev"`

### Instalar dnsmasq:
`dnfi dnsmasq`

### Configurar dnsmasq

Editar o arquivo `/etc/NetworkManager/dnsmasq.d/dnsmasq-localhost.conf` e acrescentar:

`address=/localhost.dev/127.0.0.1`

Se estiver com problema na porta 53, executar o seguinte comando para ver quem está escutando na porta 53:

`sudo ss -lp "sport = :domain"`

Se for o systemd-resolver, editar o arquivo `/etc/systemd/resolved.conf` e adicionar ou editar a linha

`DNSStubListener=no`

### Configurar NetworkManager

Editar o arquivo `/etc/NetworkManager/NetworkManager.conf` e adicionar:

```
[main]
dns=dnsmasq
```

### No caso de usar PIHOLE:
Editar o arquivo `/etc/dnsmasq.conf` e adicionar:

```
server=192.168.100.7
```

*Onde 192.168.100.7* é o endereço de IP do PIHOLE.


### Reiniciar serviços:

sudo systemctl restart systemd-resolved dnsmasq NetworkManager


