source /etc/zsh/zprofile

for sh in ${HOME}/.zsh/*.sh
do
  source $sh
done
unset sh

