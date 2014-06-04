
run() {
  docker run --rm -e SMTP_SERVER=mail.lisberg.dk -e ERRBIT_EMAIL_FROM=errbit@lisberg.dk \
    -e ERRBIT_HOST=ldbuild01.lisberg.local -e ERRBIT_PORT=3000 --link suspicious_curie:mongodb griff/errbit "$@"
}

if [ "$1" == "seed" ]; then
  run seed
else
  docker run -d --name errbit -p 3000:3000 -e SMTP_SERVER=mail.lisberg.dk -e ERRBIT_EMAIL_FROM=errbit@lisberg.dk \
    -e ERRBIT_HOST=ldbuild01.lisberg.local -e ERRBIT_PORT=3000 --link suspicious_curie:mongodb griff/errbit web
  #docker run --rm -p 3000:3000 -e SMTP_SERVER=mail.lisberg.dk -e ERRBIT_EMAIL_FROM=errbit@lisberg.dk \
  #  -e ERRBIT_HOST=ldbuild01.lisberg.local -e ERRBIT_PORT=3000 --link suspicious_curie:mongodb \
  #  -i -t griff/errbit bash
fi