while (true) ; do
rm -rf url.txt
ssh -p 443 -R0:localhost:10000 a.pinggy.io >> url.txt
done
