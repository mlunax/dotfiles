if ! type "kubectl" > /dev/null; then
  tmp_path=/tmp/kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o $tmp_path
  install $tmp_path $HOME/.local/bin
  rm $tmp_path 
fi 