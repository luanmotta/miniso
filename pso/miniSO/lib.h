/*
 * Universidade Luterana do Brasil
 * Curso de Bacharelado em Ci�ncia da Computa��o
 * Disciplina: Projeto de Sistemas Operacionais
 * Professor: Roland Teodorowitsch
 *
 * Arquivo: lib.h
 * Assunto: Prototipo das fun��es da biblioteca do minisSistema Operacional
 *
 */


#define NULL 0

typedef unsigned size_t;


/* Prototipos */
extern void      putch             (int car);
extern int       getch             (void);
extern void      clrscr            (void);
extern void      putstr            (char far *str);
extern void      putstrxy          (int x, int y, char far *string);
extern int       getcolor          (void);
extern void      setcolor          (int cor);
extern int       wherex            (void);
extern int       wherey            (void);
extern void      gotoxy            (int x,int y);
extern void      getdate           (struct date far *dt);
extern void      gettime           (struct time far *tm);
extern char far *strcpy            (char far *dest,char far *orig);
extern char far *strncpy           (char far *dest,char far *orig, size_t maxlen);
extern char far *strupr            (char far *str);
extern char far *strlwr            (char far *str);
extern int       strcmp            (char far *s1,char far *s2);
extern size_t    strlen            (char far *str);
extern int       isdigit           (char);
extern int       atoi              (char far *str);
extern void      unsignedtostr     (char far *str,unsigned i,unsigned tam,char c);
extern void      unsignedlongtostr (char far *str,unsigned long i,unsigned tam,char c);
extern void      unsignedtostrhexa (char far *str,unsigned i);
extern void      inttostr          (char far *str,int i);
extern void		   reboot			       (void);
extern pid_t	   fork			         (void (*fun)());              /* Chamada de Gerenciamento de Sistema */
extern int	     kill			         (pid_t pid);                  /* Chamada de Gerenciamento de Sistema */
extern pid_t	   wait			         (int far *status);            /* Chamada de Gerenciamento de Sistema */
extern pid_t	   waitpid		       (pid_t pid,int far *status);  /* Chamada de Gerenciamento de Sistema */
extern void		   exit			         (int codfim);                 /* Chamada de Gerenciamento de Sistema */
extern pid_t	   getpid			       (void);                       /* Chamada de Gerenciamento de Sistema */
extern pid_t	   getppid			     (void);                       /* Chamada de Gerenciamento de Sistema */
extern int		   sendsignal		     (pid_t pid, signal_t signal); /* Chamada de Gerenciamento de Sistema */
extern void		   waitsignal		     (signal_t signal);            /* Chamada de Gerenciamento de Sistema */
extern	semid_t	 semcreate		     (int value);		        /*S*/
extern	int		   semset		         (semid_t s,int value);	/*S*/
extern	int		   semup		         (semid_t s);		        /*S*/
extern	int		   semdown	         (semid_t s);		        /*S*/
extern	int		   semdestroy	     	 (semid_t s);		        /*S*/
extern  int        stop              (pid_t pid);
extern  int        resume            (pid_t pid);
extern  void       minisleep         ();
extern  int        resume            (int seconds);

