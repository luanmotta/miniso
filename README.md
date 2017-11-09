# miniso
MiniSO usado para trabalhos e implementações de chamadas de sistema na disciplina de Projetos de SO.

## To compile
```
echo "continue" > continue.rc
dosbox . &
make
bochs -q -f miniSO.bxrc -rc continue.rc
```