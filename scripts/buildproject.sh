ls -l
mkdir tmp || true
rm -rfv tmp/* || true
cat 'delta.txt' | xargs -d $'\n' --verbose -a 'delta.txt'  cp --parents -t 'tmp' || true
rm -rfv src/* || true
cp -R tmp/src/* src/
rm -rfv tmp || true