# cfssl

cfssl gencert -initca ca_csr.json  | cfssljson -bare /srv/hasCA

cfssl gencert -ca /srv/hasCA.pem -ca-key /srv/hasCA-key.pem -config="config.json" -profile="intermediate" ica-csr.json | cfssljson -bare /srv/hasICA

cfssl gencert -ca /srv/hasICA.pem -ca-key /srv/hasICA-key.pem -config=config.json -profile="server" destek.csr.json |cfssljson -bare /srv/destek

cat /srv/hasICA.pem /srv/hasCA.pem > /srv/hasCA-chain.pem



openssl verify -CAfile /srv/hasCA.pem /srv/hasICA.pem

cat /srv/hasICA.pem /srv/hasCA.pem > /srv/hasCA-chain.pem

openssl verify -CAfile hasCA-chain.pem /serv/destek.pem
cat /srv/hasICA.pem /srv/hasCA.pem > /srv/hasCA-chain.pem
