# steps

## build and deploy
```shell
# build alist-proxy image
docker build -t alist-proxy:1.0.0 .

# run alist service
docker compose up -d 
```

this command  will run alist service on port 5244 and alist-proxy service on port 5243

## configure
then you can config alist `DOWNLOAD PROXY URL` in storage drive configurations 