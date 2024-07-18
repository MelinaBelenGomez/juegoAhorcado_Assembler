.data

@Etiquetas

        @Sobre el jugador

        txt_ingreseNombre:      .asciz "\n\n Ingresar nombre de jugador/a:  "
        nombreJugador:          .zero  25
        txt_jugandoAhora:       .asciz "Jugando ahora:  "
        txt_saludo1:            .asciz "\n\n Hola "
        txt_saludo2:            .asciz " ¡Nos alegra que estes jugando con nuestro juego! ¡Que te diviertas!\n\n\n"
        mismoJugador:           .asciz "\n ¡Empecemos de nuevo! pero primero responde: ¿Sigue jugando la misma persona?  (s/n): "
        vidasJugador:           .word 6         //hago una subrutina vidas y ahi mismo busca el cara
        vidasJugadorTexto:      .asciz "6\n"
        txt_vidas:              .asciz "Vidas: "

        @validaciones

        rtaNoValida:            .asciz "\n La letra ingresada no es válida, por favor, ingresa (s/n): "
        boolAcierto:            .word 2         //si es 1 significa que la ultima letra ingresada se acertó, 0 es que no.
        boolJugandoA:           .word 1
        boolJugandoB:           .word 0

        @auxiliares
        pedirLetra:             .asciz "\nIngrese una letra para jugar:\n"
        partidaNueva:           .asciz "Fin de Juego, quieres intentarlo de nuevo? (s/n): "
        partidaGanada:          .asciz "Has ganado, desea volver a jugar? (s/n) \n"
        @juego en proceso
        palabraIncognita:       .zero 20
        letraIngresada:         .asciz "-\n"
        avanceJugador:          .zero 20        //11 de prueba para que reemplace la palabra brindada.
        guion:                  .asciz "-"


        @test
        puntoPrueba:            .asciz "\n*El programa llego hasta aca*\n"

        @dibujos
        separador:              .asciz "===================================================================\n"
        horca6:                 .asciz " _________\n |       I\n |\n |\n |\n |\n |\n---\n"
        horca5:                 .asciz " _________\n |       I\n |       O\n |\n |\n |\n |\n---\n"
        horca4:                 .asciz " _________\n |       I\n |       O\n |      /|\n |\n |\n |\n---\n"
        horca3:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |\n |\n |\n---\n"
        horca2:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |\n |\n---\n"
        horca1:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |      /\n |\n---\n"
        horca0:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |      / \\\n |\n---\n"

        @palabras para el juego
        archivo:                .asciz "listaPalabras.txt"
        palabras:               .zero 210       // "palabras\nmochila\navion\nmermelada"
        semilla:                .word 0

        dibujoTitulo:           .asciz "\n\n   /\\    |     | /TTTT\\ |TTTT\\  /TTT    /\\    |TTT\\  /TTTT\\             |----O\n  /::\\   |:::::| | X X| |____|  |      /::\\   |    | | X X|             |   /i\\\n /    \\  |     | |  O | |   \\   |     /    \\  |    | |  O |             |   _Ä_\n/      \\ |     | \\____/ |    \\  \\___ /      \\ |___/  \\____/            _A__\n"

        @Ranking
        rankingArchivo:         .asciz "ranking.txt"
        ranking_1:              .zero 250
        ranking_2:              .zero 250

        ranking_txt:            .asciz "         ~~~~~~~         \n ------- RANKING -------  \n         ~~~~~~~         \n"
        ranking_txt2:           .asciz "\n------------------------\n\n"
        txt_verRanking:         .asciz "\n¿Querés ver nuestro Ranking de top 3 ultimas jugadas? (s/n): "

        @Disparo
        ofrecerDisparo_txt:     .asciz "Podes salvar al ahorcado disparandole a la cuerda, ¿Querés intentarlo? (s/n):  "
        pedirCoordenadaX:       .asciz "Escribí a continuacion la coordenada X:   "
        pedirCoordenadaY:       .asciz "Escribí a continuacion la coordenada Y:   "
        ganoParteB:             .asciz "\nFelicidades! Con tu punteria cortaste la soga de un disparo!\n"
        perdioParteB:           .asciz "\nFallaste el disparo! No pudiste salvarlo T_T\n"

        coorXingresada:         .zero 2
                                .asciz "\n"
        coordenadaX:            .word 0

        coorYingresada:         .zero 2
                                .asciz "\n"
        coordenadaY:            .word 0


.text

@------------[ Pantalla de Juego ]-------------@
dibujarTitulo:
.fnstart
        push {r1, lr}

        ldr r1, =dibujoTitulo
        bl imprimir

        pop {r1, lr}
        bx lr
.fnend

dibujarHorca:
.fnstart
        push {r0,r1,lr}
        ldr r1, =separador
        bl imprimir

        ldr r0, =vidasJugador
        ldr r0, [r0]

        cmp r0, #6
        beq dibujarVidas6
        cmp r0, #5
        beq dibujarVidas5
        cmp r0, #4
        beq dibujarVidas4
        cmp r0, #3
        beq dibujarVidas3
        cmp r0, #2
        beq dibujarVidas2
        cmp r0, #1
        beq dibujarVidas1
        ldr r1, =horca0
        bal salir_dibujarHorca

        dibujarVidas6:
        ldr r1, =horca6
        bal salir_dibujarHorca

        dibujarVidas5:
        ldr r1, =horca5
        bal salir_dibujarHorca

        dibujarVidas4:
        ldr r1, =horca4
        bal salir_dibujarHorca

        dibujarVidas3:
        ldr r1, =horca3
        bal salir_dibujarHorca

        dibujarVidas2:
        ldr r1, =horca2
        bal salir_dibujarHorca

        dibujarVidas1:
        ldr r1, =horca1
        bal salir_dibujarHorca

        salir_dibujarHorca:
        bl imprimir
        pop {r0,r1,lr}
        bx lr
.fnend

mostrarJugadorActual:
.fnstart
        push {r1,lr}

        ldr r1, =txt_jugandoAhora
        bl imprimir
        ldr r1, =nombreJugador
        bl imprimir

        pop {r1,lr}
        bx lr

.fnend

mostrarVidas:
.fnstart
        push {r1,lr}

        ldr r1, =txt_vidas
        bl imprimir

        ldr r1, =vidasJugadorTexto
        bl imprimir

        pop {r1, lr}
        bx lr
.fnend

mostrarRanking:
.fnstart
        push {r1,lr}

        bl importarRanking

        ldr r1, =ranking_txt
        bl imprimir

        ldr r1, =ranking_1
        bl imprimir

        ldr r1, =ranking_txt2
        bl imprimir

        pop {r1,lr}
        bx lr
.fnend


@-----------[ lógica de Juego ]----------------@

preguntarVerRanking:
.fnstart
        push {r1,lr}

        ldr r1, =txt_verRanking
        bl imprimir

        ciclo_verRanking:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]

        cmp r1, #0x73   //s
        beq verRank
        cmp r1, #0x6E   //n
        beq salirDePreguntarVerRanking

        ldr r1, =rtaNoValida
        bl imprimir
        bal ciclo_verRanking

        verRank:
        bl mostrarRanking
        bal salirDePreguntarVerRanking

        salirDePreguntarVerRanking:
        pop {r1,lr}
        bx lr
.fnend

obtenerNombreDeJugador:
.fnstart
        push {r0,r1,r2,r7,lr}
        ldr r1, =txt_ingreseNombre
        bl imprimir

        leerNombre:
        mov r0, #0
        ldr r1, =nombreJugador
        mov r2, #25
        mov r7, #3
        swi 0

        borrarCaracteresSucios:
        ldr r1, =nombreJugador

        bucleChar:
        ldrb r2, [r1]
        cmp r2, #10
        beq sobreescribirCeros
        add r1, #1
        bal bucleChar

        sobreescribirCeros:
        mov r4, #0
        strb r4, [r1]

        saludarJugador:
        ldr r1, =txt_saludo1
        bl imprimir
        ldr r1, =nombreJugador
        bl imprimir
        ldr r1, =txt_saludo2
        bl imprimir

        salirDeObtenerNombre:
        pop {r0,r1,r2,r7,lr}
        bx lr

.fnend

seleccionarPalabra:
.fnstart
        push {r0,r1,r2,r3,r4,r5,lr}
        bl random
        ldr r0, =semilla
        ldr r0, [r0]
        ldr r1,=palabras
        ldr r3,=palabraIncognita
        mov r4, #0
        mov r5, #0

        cicloSeleccionarPalabra:
        cmp r4, r0
        bgt salirSeleccionarPalabra
        beq actualizarIncognita
        ldrb r2, [r1]
        cmp r2, #10
        beq siguientePalabra
        add r1, #1
        bal cicloSeleccionarPalabra

        actualizarIncognita:
        ldrb r2, [r1]
        strb r2, [r3]
        add r1, #1
        add r3, #1
        cmp r2, #10
        beq siguientePalabra
        bal cicloSeleccionarPalabra

        siguientePalabra:
        add r4, #1
        add r1, #1
        bal cicloSeleccionarPalabra

        salirSeleccionarPalabra:
        strb r5,[r3]            //cargamos un 0 al final de r3
        pop {r0,r1,r2,r3,r4,r5,lr}
        bx lr
.fnend

reiniciarAvance:
.fnstart
        push {r0,r1,r2,r3,lr}
        ldr r0, =guion
        ldrb r0, [r0]
        ldr r1, =palabraIncognita
        ldr r3, =avanceJugador

        cicloReiniciarAvance:
        ldrb r2, [r1]
        cmp r2, #10
        beq salirReiniciarAvance
        strb r0, [r3]
        add r1, #1
        add r3, #1
        bal cicloReiniciarAvance

        salirReiniciarAvance:
        strb r2, [r3]
        add r3, #1
        mov r2, #0
        strb r2,[r3]
        pop {r0,r1,r2,r3,lr}
        bx lr
.fnend

reiniciarJugador:
.fnstart

        push {r0,r1,lr}
        ldr r1, =mismoJugador
        bl imprimir

        pedirConf:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]

        cmp r1, #0x73           //s
        beq salirDeReiniciarJugador

        cmp r1, #0x6E           //n
        beq cambiarNombre

        ldr r1, =rtaNoValida
        bl imprimir
        bal pedirConf

        cambiarNombre:
        bl obtenerNombreDeJugador

        salirDeReiniciarJugador:
        bl preguntarVerRanking
        pop {r0,r1,lr}
        bx lr

.fnend

comprobarVictoria:
.fnstart
        push {r0,r1,r2,r3,lr}
        ldr r0, =guion
        ldrb r0, [r0]
        ldr r1, =avanceJugador
        ciclo_comprobarVictoria:
        ldrb r2, [r1]
        cmp r0, r2
        beq salir_comprobarVictoria
        cmp r2, #10
        beq ganoPartida
        add r1, #1
        bal ciclo_comprobarVictoria

        ganoPartida:
        bl agregarJugadorARanking
        ldr r1, =avanceJugador
        bl imprimir
        ldr r1, =partidaGanada
        bl imprimir

        ciclo_ingLetra:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]
        cmp r1, #0x73           //s
        beq reiniciarVictoria
        cmp r1, #0x6E           //n
        beq noQuiereReiniciar
        ldr r1, =rtaNoValida
        bl imprimir
        bal  ciclo_ingLetra

        noQuiereReiniciar:
        mov r2, #0
        ldr r1, =boolJugandoA
        str r2, [r1]
        bal salir_comprobarVictoria

        reiniciarVictoria:
        ldr r1, =vidasJugador
        mov r2, #6
        str r2, [r1]
        ldr r1, =vidasJugadorTexto
        mov r2, #0x36
        strb r2, [r1]
        bl seleccionarPalabra
        bl reiniciarAvance
        bl reiniciarJugador

        salir_comprobarVictoria:
        pop  {r0,r1,r2,r3,lr}
        bx lr
.fnend

comprobarDerrota:
.fnstart
        push {r1,r2,lr}
        ldr r1, =vidasJugador
        ldr r2, [r1]
        cmp r2, #0
        beq perdio_Partida
        bal salir_comprobar

        perdio_Partida:
        bl agregarJugadorARanking
        bl dibujarHorca
        bl mostrarVidas
        bl ofrecerDisparo
        ldr r1, =partidaNueva
        bl imprimir

        cicloPregReinicio_perdio:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r2, [r1]
        cmp r2, #0x73           //s
        beq reiniciarDerrota
        cmp r2, #0x6E           //n
        beq noQuiereRein
        ldr r1, =rtaNoValida
        bl imprimir
        bal cicloPregReinicio_perdio

        noQuiereRein:
        ldr r1, =boolJugandoA
        mov r2, #0
        str r2, [r1]
        bal salir_comprobar

        reiniciarDerrota:
        ldr r1, =vidasJugador
        mov r2, #6
        str r2, [r1]
        ldr r1, =vidasJugadorTexto
        mov r2, #0x36
        strb r2, [r1]
        bl seleccionarPalabra
        bl reiniciarAvance
        bl reiniciarJugador

        salir_comprobar:
        pop {r1,r2,lr}
        bx lr
.fnend

ofrecerDisparo:
.fnstart
        push {r1,lr}
        ldr r1, =ofrecerDisparo_txt
        bl imprimir

        ciclo_OfrecerDisparo:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]
        cmp r1, #0x73   //s
        beq pedirCoordenadasDisparo
        cmp r1, #0x6E   //n
        beq salirDeOfrecerDisparo
        ldr r1, =rtaNoValida
        bl imprimir
        bal ciclo_OfrecerDisparo

        pedirCoordenadasDisparo:
        ldr r1, =pedirCoordenadaX
        bl imprimir
        bl ingresarCoordenadaX

        ldr r1, =pedirCoordenadaY
        bl imprimir
        bl ingresarCoordenadaY

        convertirCoordenadaX:
        mov r0, #0
        ldr r1, =coorXingresada
        ldrb r2, [r1]
        sub r2, #0x30
        mov r3, #10
        mul r0, r2, r3

        add r1, #1
        ldrb r2, [r1]
        sub r2, #0x30
        add r0, r2

        ldr r1, =coordenadaX
        str r0, [r1]

        convertirCoordenadaY:
        mov r0, #0
        ldr r1, =coorYingresada
        ldrb r2, [r1]
        sub r2, #0x30
        mov r3, #10
        mul r0, r2, r3

        add r1, #1
        ldrb r2, [r1]
        sub r2, #0x30
        add r0, r2

        ldr r1, =coordenadaY
        str r0, [r1]

        comprobarPunteria:
        ldr r1, =coordenadaX
        ldr r1, [r1]
        ldr r2, =coordenadaY
        ldr r2, [r2]
        cmp r1, #9
        bne erroDisparo
        cmp r2, #7
        bne erroDisparo
        ldr r1, =ganoParteB
        bl imprimir
        bal salirDeOfrecerDisparo

        erroDisparo:
        ldr r1, =perdioParteB
        bl imprimir

        salirDeOfrecerDisparo:
        pop {r1,lr}
        bx lr
.fnend

analizarIngreso:
.fnstart
        push {r0,r1,r2,r3,r4,lr}
        ldr r1, =palabraIncognita               //palabra incognita
        ldr r3, =letraIngresada                 //letra ingresada por el jugador
        ldrb r3, [r3]
        mov r4, #0                              //bool empieza en cero, si no se modifica queda en "no coincidencia"

        ciclo_analizarIngreso:
        cmp r4, #1                              //si ya hubo coincidencia termina la comprobacion
        beq salir_analizarIngreso

        ldrb r2, [r1]
        cmp r2, #10                             //si llego al fin de la palabra termina la comprobacion
        beq salir_analizarIngreso
        cmp r2, r3                              //si encuentra coincidencia entre letra e incognita va a cambiar r4
        beq letraAparece
        add r1, #1                              //si no paso nada de lo anterior apunta al siguiente y repite
        bal ciclo_analizarIngreso

        letraAparece:
        mov r4, #1                              //cambia el boolenao
        add r1, #1                              //apunta a la siguiente letra y repite
        bal ciclo_analizarIngreso

        salir_analizarIngreso:
        ldr r0, =boolAcierto                    //modifica la etiqueta del booleano
        strb r4, [r0]
        pop  {r0,r1,r2,r3,r4,lr}
        bx lr
.fnend

reemplazarLetraEnAvanceJugador:
@reemplaza la letra ingresada por el usuario en avanceJugador, no tiene return, modifica etiquetas

.fnstart
        push {r0,r1,r2,r3,r4,r5,lr}
        ldr r0, =boolAcierto
        ldrb r0, [r0]
        cmp r0, #0
        beq salir_reemplazarLetra

        ldr r0, =letraIngresada                 //letra ingresada por el usuario
        ldrb r0, [r0]
        ldr r1, =palabraIncognita               //recorriendo la palabra incognita para ver donde se reemplaza la letra
        ldr r3, =avanceJugador                  //avance del jugador, aca se van reemplazando los guiones por letras

        ciclo_reemplazarLetra:
        ldrb r2, [r1]                           //bajo de la memoria la letra de incognita
        cmp r2, #10                             //si es el salto de lina termina
        beq salir_reemplazarLetra
        cmp r2, r0                              //si las letras coinciden pasa a reemplazar en avance
        beq reemplazarLetra
        add r1, #1                              //apunta a las siguientes letras de incognita y avance y repite
        add r3, #1
        bal ciclo_reemplazarLetra

        reemplazarLetra:
        strb r2, [r3]                           //reemplaza el guion en avance por la letra ingresada
        add r1, #1                              //awpunta a las siguientes letras de incognita y avance y retoma el ciclo
        add r3, #1
        bal ciclo_reemplazarLetra

        salir_reemplazarLetra:
        pop  {r0,r1,r2,r3,r4,r5,lr}
        bx lr
.fnend

actualizarVidas:
.fnstart
        push {r0,r1,r2,lr}
        ldr r0, =boolAcierto
        ldrb r0, [r0]
        cmp r0, #0
        beq restarVida
        bal salirDeActualizarVidas

        restarVida:
        ldr r1, =vidasJugador
        ldr r2, [r1]
        sub r2, #1
        str r2, [r1]

        ldr r1, =vidasJugadorTexto
        ldrb r2, [r1]
        sub r2, #1
        strb r2, [r1]

        salirDeActualizarVidas:
        pop {r0,r1,r2,lr}
        bx lr
.fnend


@--------[ Funciones Auxiliares ]---------@

importarRanking:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r7, #5
        ldr r0, =rankingArchivo         //busca el archivo por el nombre en esta etiq
        mov r1, #2                      //0 lectura, 1 escritura, 2 ambos
        mov r2, #438
        swi 0

        @Proceso de lectura del archivo

        mov r7, #3
        ldr r1, =ranking_1              //donde poner el cont. leído
        mov r2, #250
        swi 0

        @cerrar el archivo
        mov r0, r6
        mov r7, #6
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend


agregarJugadorARanking:
.fnstart
        push {r1,r2,r3,lr}
        ldr r1, =nombreJugador
        ldr r3, =ranking_2

        cicloAgregarJugador:
        ldrb r2, [r1]
        cmp r2, #0
        beq agregarPuntaje
        strb r2, [r3]
        add r1, #1
        add r3, #1
        bal cicloAgregarJugador

        agregarPuntaje:
        mov r2, #0x20                   //espacio
        strb r2, [r3]
        add r3, #1
        ldr r1, =vidasJugadorTexto
        ldr r2, [r1]
        str r2, [r3]
        add r3, #2
        ldr r1, =ranking_1
        mov r4, #0                              //contar la cantidad de saltos de lineas

        cicloRankingAnterior:
        ldrb r2, [r1]                           //empiezo a cargar los bytes del ranking viejo
        cmp r2, #10                             //identifico salto de linea
        beq siguienteNombre
        strb r2, [r3]
        add r1, #1
        add r3, #1
        bal cicloRankingAnterior

        siguienteNombre:
        strb r2, [r3]
        add r1, #1
        add r3, #1
        add r4, #1
        cmp r4, #2
        beq completarConCeros
        bal cicloRankingAnterior

        completarConCeros:
        mov r2, #0
        strb r2, [r3]
        ldr r1, =ranking_2
        bl calcularCaracteres
        mov r4, #250
        sub r4, r2
        mov r2, #0x20

        escribirCero:
        cmp r4, #0
        beq salirActualizarRanking
        strb r2, [r3]
        add r3, #1
        sub r4, #1
        bal escribirCero

        salirActualizarRanking:
        bl exportarRanking
        pop {r1,r2,r3,lr}
        bx lr
.fnend

exportarRanking:
.fnstart
        push {r0,r1,r2,r6,r7,lr}
        mov r7, #5
        ldr r0, =rankingArchivo         //busca el archivo por el nombre en esta etiq
        mov r1, #1                      //0 lectura, 1 escritura, 2 ambos
        mov r2, #438
        swi 0

        mov r6, r0

        mov r0, r6
        mov r7, #4
        ldr r1, =ranking_2
        mov r2, #250
        sub r2, #1
        swi 0

        @cerrar el archivo
        mov r0, r6
        mov r7, #6
        swi 0
        pop {r0,r1,r2,r6,r7,lr}
        bx lr
.fnend

importarListaDePalabras: .fnstart
        push {r1,r2,r7,lr}
        mov r7, #5              //abre el archivo
        ldr r0, =archivo
        mov r1, #2
        mov r2, #438
        swi 0

        mov r7, #3              //guarda las palabras en bufferLemario separadas por salto de linea
        ldr r1, =palabras
        mov r2, #200
        swi 0

        mov r0, r6
        mov r7, #6
        swi 0
        pop  {r1,r2,r7,lr}
        bx lr
.fnend

random:
.fnstart
        push {r1,r2,r7,lr}
        mov r7, #384
        ldr r0, =semilla
        mov r1, #4
        mov r2, #0
        swi 0
        ldr r1, =semilla
        ldr r0, [r1]
        and r0, r0, #15         //hacemos un and con 15 para obtener el ultimo byte del numero aleatorio (0000 0000 0000 1111, si aplicamos la logica del and,  en todas las posiciones que sea 0 va a seguir siendo 0, y en las que sea uno va a ser igual a lo que contenga la semilla, ya que 1 AND A =  A)
        str r0, [r1]
        pop  {r1,r2,r7,lr}
        bx lr
.fnend

ingresarLetra:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =letraIngresada
        mov r2, #10
        mov r7, #3
        swi 0
        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

ingresarCoordenadaX:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =coorXingresada
        mov r2, #3
        mov r7, #3
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

ingresarCoordenadaY:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =coorYingresada
        mov r2, #3
        mov r7, #3
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

calcularCaracteres:
@cuenta la cantidad de caracteres que tiene una cadena incluyendo el salto de linea. Termina con el 0
@cadena apuntada con r1
@salida en r2
.fnstart
        push {r1,r3,lr}  @guardo los valores excepto la respuesta que necesito de esta subrutina
        mov r2, #0      @r2 va a ser mi contador, como necesito el valor no lo meto en el stack.

        ciclo:
        ldrb r3, [r1]           @cargo 1 byte
        cmp r3, #0              @1er comp del caracter con el inmediato 0
        beq finCaracteres       @compara los ultimos dos valoes para ver si es el final, -condicional

        add r2, #1              @incrementador del contador
        add r1, #1              @incrementador de bytes
        bal ciclo

        finCaracteres:
        pop {r1,r3,lr}
        bx lr                   @regreso
.fnend


imprimir:               @imprime r1
.fnstart
        push {r0,r7,lr}
        mov r0, #1              @info imprimir 1
        mov r7, #4              @info imprimir 2
        bl calcularCaracteres
        swi 0

        pop {r0,r7,lr}          @si falla aca le tengo que volver a poner el r2 y probar.
        bx lr

.fnend


.global main
main:

        bl importarListaDePalabras
        bl seleccionarPalabra
        bl reiniciarAvance
        bl dibujarTitulo
        bl obtenerNombreDeJugador
        bl preguntarVerRanking


        juegoA:
        bl dibujarHorca
        bl mostrarVidas
        bl mostrarJugadorActual
        ldr r1, =pedirLetra                     //mensaje de ingresar una letra
        bl imprimir
        ldr r1, =avanceJugador                  //imprime el avance del jugador
        bl imprimir

        bl ingresarLetra                        //r1 letra escrita (input)
        bl analizarIngreso                      //analizar si la letra es valida viendo si esta en incognita y se actualiza el bool
        bl actualizarVidas
        bl reemplazarLetraEnAvanceJugador       //se reemplaza la letra en avanceJugador
        bl comprobarDerrota
        bl comprobarVictoria

        ldr r0, =boolJugandoA
        ldrb r0, [r0]
        cmp r0, #1
        beq juegoA

        gameOver:

        mov r7, #1                      @fin del programa
        swi 0
occ2g14@Alysa:~ $ nano juego.asm -lmS
occ2g14@Alysa:~ $ cat juego.asm
.data

@Etiquetas

        @Sobre el jugador

        txt_ingreseNombre:      .asciz "\n\n Ingresar nombre de jugador/a:  "
        nombreJugador:          .zero  25
        txt_jugandoAhora:       .asciz "Jugando ahora:  "
        txt_saludo1:            .asciz "\n\n Hola "
        txt_saludo2:            .asciz " ¡Nos alegra que estes jugando con nuestro juego! ¡Que te diviertas!\n\n\n"
        mismoJugador:           .asciz "\n ¡Empecemos de nuevo! pero primero responde: ¿Sigue jugando la misma persona?  (s/n): "
        vidasJugador:           .word 6
        vidasJugadorTexto:      .asciz "6\n"
        txt_vidas:              .asciz "Vidas: "

        @validaciones

        rtaNoValida:            .asciz "\n La letra ingresada no es válida, por favor, ingresa (s/n): "
        boolAcierto:            .word 2         //si es 1 significa que la ultima letra ingresada se acertó, 0 es que no.
        boolJugandoA:           .word 1
        boolJugandoB:           .word 0

        @auxiliares
        pedirLetra:             .asciz "\nIngrese una letra para jugar:\n"
        partidaNueva:           .asciz "Fin de Juego, quieres intentarlo de nuevo? (s/n): "
        partidaGanada:          .asciz "Has ganado, desea volver a jugar? (s/n) \n"
        @juego en proceso
        palabraIncognita:       .zero 20
        letraIngresada:         .asciz "-\n"
        avanceJugador:          .zero 20
        guion:                  .asciz "-"


        @test
        puntoPrueba:            .asciz "\n*El programa llego hasta aca*\n"

        @dibujos
        separador:              .asciz "===================================================================\n"
        horca6:                 .asciz " _________\n |       I\n |\n |\n |\n |\n |\n---\n"
        horca5:                 .asciz " _________\n |       I\n |       O\n |\n |\n |\n |\n---\n"
        horca4:                 .asciz " _________\n |       I\n |       O\n |      /|\n |\n |\n |\n---\n"
        horca3:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |\n |\n |\n---\n"
        horca2:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |\n |\n---\n"
        horca1:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |      /\n |\n---\n"
        horca0:                 .asciz " _________\n |       I\n |       O\n |      /|\\\n |       |\n |      / \\\n |\n---\n"

        @palabras para el juego
        archivo:                .asciz "listaPalabras.txt"
        palabras:               .zero 210
        semilla:                .word 0

        dibujoTitulo:           .asciz "\n\n   /\\    |     | /TTTT\\ |TTTT\\  /TTT    /\\    |TTT\\  /TTTT\\             |----O\n  /::\\   |:::::| | X X| |____|  |      /::\\   |    | | X X|             |   /i\\\n /    \\  |     | |  O | |   \\   |     /    \\  |    | |  O |             |   _Ä_\n/      \\ |     | \\____/ |    \\  \\___ /      \\ |___/  \\____/            _A__\n"

        @Ranking
        rankingArchivo:         .asciz "ranking.txt"
        ranking_1:              .zero 250
        ranking_2:              .zero 250

        ranking_txt:            .asciz "         ~~~~~~~         \n ------- RANKING -------  \n         ~~~~~~~         \n"
        ranking_txt2:           .asciz "\n------------------------\n\n"
        txt_verRanking:         .asciz "\n¿Querés ver nuestro Ranking de top 3 ultimas jugadas? (s/n): "

        @Disparo
        ofrecerDisparo_txt:     .asciz "Podes salvar al ahorcado disparandole a la cuerda, ¿Querés intentarlo? (s/n):  "
        pedirCoordenadaX:       .asciz "Escribí a continuacion la coordenada X:   "
        pedirCoordenadaY:       .asciz "Escribí a continuacion la coordenada Y:   "
        ganoParteB:             .asciz "\nFelicidades! Con tu punteria cortaste la soga de un disparo!\n"
        perdioParteB:           .asciz "\nFallaste el disparo! No pudiste salvarlo T_T\n"

        coorXingresada:         .zero 2
                                .asciz "\n"
        coordenadaX:            .word 0

        coorYingresada:         .zero 2
                                .asciz "\n"
        coordenadaY:            .word 0


.text

@------------[ Pantalla de Juego ]-------------@
dibujarTitulo:
.fnstart
        push {r1, lr}

        ldr r1, =dibujoTitulo
        bl imprimir

        pop {r1, lr}
        bx lr
.fnend

dibujarHorca:
.fnstart
        push {r0,r1,lr}
        ldr r1, =separador
        bl imprimir

        ldr r0, =vidasJugador
        ldr r0, [r0]

        cmp r0, #6
        beq dibujarVidas6
        cmp r0, #5
        beq dibujarVidas5
        cmp r0, #4
        beq dibujarVidas4
        cmp r0, #3
        beq dibujarVidas3
        cmp r0, #2
        beq dibujarVidas2
        cmp r0, #1
        beq dibujarVidas1
        ldr r1, =horca0
        bal salir_dibujarHorca

        dibujarVidas6:
        ldr r1, =horca6
        bal salir_dibujarHorca

        dibujarVidas5:
        ldr r1, =horca5
        bal salir_dibujarHorca

        dibujarVidas4:
        ldr r1, =horca4
        bal salir_dibujarHorca

        dibujarVidas3:
        ldr r1, =horca3
        bal salir_dibujarHorca

        dibujarVidas2:
        ldr r1, =horca2
        bal salir_dibujarHorca

        dibujarVidas1:
        ldr r1, =horca1
        bal salir_dibujarHorca

        salir_dibujarHorca:
        bl imprimir
        pop {r0,r1,lr}
        bx lr
.fnend

mostrarJugadorActual:
.fnstart
        push {r1,lr}

        ldr r1, =txt_jugandoAhora
        bl imprimir
        ldr r1, =nombreJugador
        bl imprimir

        pop {r1,lr}
        bx lr

.fnend

mostrarVidas:
.fnstart
        push {r1,lr}

        ldr r1, =txt_vidas
        bl imprimir

        ldr r1, =vidasJugadorTexto
        bl imprimir

        pop {r1, lr}
        bx lr
.fnend

mostrarRanking:
.fnstart
        push {r1,lr}

        bl importarRanking

        ldr r1, =ranking_txt
        bl imprimir

        ldr r1, =ranking_1
        bl imprimir

        ldr r1, =ranking_txt2
        bl imprimir

        pop {r1,lr}
        bx lr
.fnend


@-----------[ lógica de Juego ]----------------@

preguntarVerRanking:
.fnstart
        push {r1,lr}

        ldr r1, =txt_verRanking
        bl imprimir

        ciclo_verRanking:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]

        cmp r1, #0x73   //s
        beq verRank
        cmp r1, #0x6E   //n
        beq salirDePreguntarVerRanking

        ldr r1, =rtaNoValida
        bl imprimir
        bal ciclo_verRanking

        verRank:
        bl mostrarRanking
        bal salirDePreguntarVerRanking

        salirDePreguntarVerRanking:
        pop {r1,lr}
        bx lr
.fnend

obtenerNombreDeJugador:
.fnstart
        push {r0,r1,r2,r7,lr}
        ldr r1, =txt_ingreseNombre
        bl imprimir

        leerNombre:
        mov r0, #0
        ldr r1, =nombreJugador
        mov r2, #25
        mov r7, #3
        swi 0

        borrarCaracteresSucios:
        ldr r1, =nombreJugador

        bucleChar:
        ldrb r2, [r1]
        cmp r2, #10
        beq sobreescribirCeros
        add r1, #1
        bal bucleChar

        sobreescribirCeros:
        mov r4, #0
        strb r4, [r1]

        saludarJugador:
        ldr r1, =txt_saludo1
        bl imprimir
        ldr r1, =nombreJugador
        bl imprimir
        ldr r1, =txt_saludo2
        bl imprimir

        salirDeObtenerNombre:
        pop {r0,r1,r2,r7,lr}
        bx lr

.fnend

seleccionarPalabra:
.fnstart
        push {r0,r1,r2,r3,r4,r5,lr}
        bl random
        ldr r0, =semilla
        ldr r0, [r0]
        ldr r1,=palabras
        ldr r3,=palabraIncognita
        mov r4, #0
        mov r5, #0

        cicloSeleccionarPalabra:
        cmp r4, r0
        bgt salirSeleccionarPalabra
        beq actualizarIncognita
        ldrb r2, [r1]
        cmp r2, #10
        beq siguientePalabra
        add r1, #1
        bal cicloSeleccionarPalabra

        actualizarIncognita:
        ldrb r2, [r1]
        strb r2, [r3]
        add r1, #1
        add r3, #1
        cmp r2, #10
        beq siguientePalabra
        bal cicloSeleccionarPalabra

        siguientePalabra:
        add r4, #1
        add r1, #1
        bal cicloSeleccionarPalabra

        salirSeleccionarPalabra:
        strb r5,[r3]            //cargamos un 0 al final de r3
        pop {r0,r1,r2,r3,r4,r5,lr}
        bx lr
.fnend

reiniciarAvance:
.fnstart
        push {r0,r1,r2,r3,lr}
        ldr r0, =guion
        ldrb r0, [r0]
        ldr r1, =palabraIncognita
        ldr r3, =avanceJugador

        cicloReiniciarAvance:
        ldrb r2, [r1]
        cmp r2, #10
        beq salirReiniciarAvance
        strb r0, [r3]
        add r1, #1
        add r3, #1
        bal cicloReiniciarAvance

        salirReiniciarAvance:
        strb r2, [r3]
        add r3, #1
        mov r2, #0
        strb r2,[r3]
        pop {r0,r1,r2,r3,lr}
        bx lr
.fnend

reiniciarJugador:
.fnstart

        push {r0,r1,lr}
        ldr r1, =mismoJugador
        bl imprimir

        pedirConf:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]

        cmp r1, #0x73           //s
        beq salirDeReiniciarJugador

        cmp r1, #0x6E           //n
        beq cambiarNombre

        ldr r1, =rtaNoValida
        bl imprimir
        bal pedirConf

        cambiarNombre:
        bl obtenerNombreDeJugador

        salirDeReiniciarJugador:
        bl preguntarVerRanking
        pop {r0,r1,lr}
        bx lr

.fnend

comprobarVictoria:
.fnstart
        push {r0,r1,r2,r3,lr}
        ldr r0, =guion
        ldrb r0, [r0]
        ldr r1, =avanceJugador
        ciclo_comprobarVictoria:
        ldrb r2, [r1]
        cmp r0, r2
        beq salir_comprobarVictoria
        cmp r2, #10
        beq ganoPartida
        add r1, #1
        bal ciclo_comprobarVictoria

        ganoPartida:
        bl agregarJugadorARanking
        ldr r1, =avanceJugador
        bl imprimir
        ldr r1, =partidaGanada
        bl imprimir

        ciclo_ingLetra:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]
        cmp r1, #0x73           //s
        beq reiniciarVictoria
        cmp r1, #0x6E           //n
        beq noQuiereReiniciar
        ldr r1, =rtaNoValida
        bl imprimir
        bal  ciclo_ingLetra

        noQuiereReiniciar:
        mov r2, #0
        ldr r1, =boolJugandoA
        str r2, [r1]
        bal salir_comprobarVictoria

        reiniciarVictoria:
        ldr r1, =vidasJugador
        mov r2, #6
        str r2, [r1]
        ldr r1, =vidasJugadorTexto
        mov r2, #0x36
        strb r2, [r1]
        bl seleccionarPalabra
        bl reiniciarAvance
        bl reiniciarJugador

        salir_comprobarVictoria:
        pop  {r0,r1,r2,r3,lr}
        bx lr
.fnend

comprobarDerrota:
.fnstart
        push {r1,r2,lr}
        ldr r1, =vidasJugador
        ldr r2, [r1]
        cmp r2, #0
        beq perdio_Partida
        bal salir_comprobar

        perdio_Partida:
        bl agregarJugadorARanking
        bl dibujarHorca
        bl mostrarVidas
        bl ofrecerDisparo
        ldr r1, =partidaNueva
        bl imprimir

        cicloPregReinicio_perdio:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r2, [r1]
        cmp r2, #0x73           //s
        beq reiniciarDerrota
        cmp r2, #0x6E           //n
        beq noQuiereRein
        ldr r1, =rtaNoValida
        bl imprimir
        bal cicloPregReinicio_perdio

        noQuiereRein:
        ldr r1, =boolJugandoA
        mov r2, #0
        str r2, [r1]
        bal salir_comprobar

        reiniciarDerrota:
        ldr r1, =vidasJugador
        mov r2, #6
        str r2, [r1]
        ldr r1, =vidasJugadorTexto
        mov r2, #0x36
        strb r2, [r1]
        bl seleccionarPalabra
        bl reiniciarAvance
        bl reiniciarJugador

        salir_comprobar:
        pop {r1,r2,lr}
        bx lr
.fnend

ofrecerDisparo:
.fnstart
        push {r1,lr}
        ldr r1, =ofrecerDisparo_txt
        bl imprimir

        ciclo_OfrecerDisparo:
        bl ingresarLetra
        ldr r1, =letraIngresada
        ldrb r1, [r1]
        cmp r1, #0x73   //s
        beq pedirCoordenadasDisparo
        cmp r1, #0x6E   //n
        beq salirDeOfrecerDisparo
        ldr r1, =rtaNoValida
        bl imprimir
        bal ciclo_OfrecerDisparo

        pedirCoordenadasDisparo:
        ldr r1, =pedirCoordenadaX
        bl imprimir
        bl ingresarCoordenadaX

        ldr r1, =pedirCoordenadaY
        bl imprimir
        bl ingresarCoordenadaY

        convertirCoordenadaX:
        mov r0, #0
        ldr r1, =coorXingresada
        ldrb r2, [r1]
        sub r2, #0x30
        mov r3, #10
        mul r0, r2, r3

        add r1, #1
        ldrb r2, [r1]
        sub r2, #0x30
        add r0, r2

        ldr r1, =coordenadaX
        str r0, [r1]

        convertirCoordenadaY:
        mov r0, #0
        ldr r1, =coorYingresada
        ldrb r2, [r1]
        sub r2, #0x30
        mov r3, #10
        mul r0, r2, r3

        add r1, #1
        ldrb r2, [r1]
        sub r2, #0x30
        add r0, r2

        ldr r1, =coordenadaY
        str r0, [r1]

        comprobarPunteria:
        ldr r1, =coordenadaX
        ldr r1, [r1]
        ldr r2, =coordenadaY
        ldr r2, [r2]
        cmp r1, #9
        bne erroDisparo
        cmp r2, #7
        bne erroDisparo
        ldr r1, =ganoParteB
        bl imprimir
        bal salirDeOfrecerDisparo

        erroDisparo:
        ldr r1, =perdioParteB
        bl imprimir

        salirDeOfrecerDisparo:
        pop {r1,lr}
        bx lr
.fnend

analizarIngreso:
.fnstart
        push {r0,r1,r2,r3,r4,lr}
        ldr r1, =palabraIncognita
        ldr r3, =letraIngresada
        ldrb r3, [r3]
        mov r4, #0                              //bool empieza en cero, si no se modifica queda en "no coincidencia"

        ciclo_analizarIngreso:
        cmp r4, #1
        beq salir_analizarIngreso

        ldrb r2, [r1]
        cmp r2, #10                             //si llego al fin de la palabra termina la comprobacion
        beq salir_analizarIngreso
        cmp r2, r3
        beq letraAparece
        add r1, #1
        bal ciclo_analizarIngreso

        letraAparece:
        mov r4, #1                      //cambia el boolenao
        add r1, #1
        bal ciclo_analizarIngreso

        salir_analizarIngreso:
        ldr r0, =boolAcierto                    //modifica la etiqueta del booleano
        strb r4, [r0]
        pop  {r0,r1,r2,r3,r4,lr}
        bx lr
.fnend

reemplazarLetraEnAvanceJugador:
@reemplaza la letra ingresada por el usuario en avanceJugador, no tiene return, modifica etiquetas

.fnstart
        push {r0,r1,r2,r3,r4,r5,lr}
        ldr r0, =boolAcierto
        ldrb r0, [r0]
        cmp r0, #0
        beq salir_reemplazarLetra

        ldr r0, =letraIngresada
        ldrb r0, [r0]
        ldr r1, =palabraIncognita
        ldr r3, =avanceJugador

        ciclo_reemplazarLetra:
        ldrb r2, [r1]
        cmp r2, #10                             //salto de linea
        beq salir_reemplazarLetra
        cmp r2, r0
        beq reemplazarLetra
        add r1, #1
        add r3, #1
        bal ciclo_reemplazarLetra

        reemplazarLetra:
        strb r2, [r3]                           //reemplaza el guion en avance por la letra ingresada
        add r1, #1
        add r3, #1
        bal ciclo_reemplazarLetra

        salir_reemplazarLetra:
        pop  {r0,r1,r2,r3,r4,r5,lr}
        bx lr
.fnend

actualizarVidas:
.fnstart
        push {r0,r1,r2,lr}
        ldr r0, =boolAcierto
        ldrb r0, [r0]
        cmp r0, #0
        beq restarVida
        bal salirDeActualizarVidas

        restarVida:
        ldr r1, =vidasJugador
        ldr r2, [r1]
        sub r2, #1
        str r2, [r1]

        ldr r1, =vidasJugadorTexto
        ldrb r2, [r1]
        sub r2, #1
        strb r2, [r1]

        salirDeActualizarVidas:
        pop {r0,r1,r2,lr}
        bx lr
.fnend


@--------[ Funciones Auxiliares ]---------@

importarRanking:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r7, #5
        ldr r0, =rankingArchivo         //busca el archivo por el nombre en esta etiq
        mov r1, #2                      //0 lectura, 1 escritura, 2 ambos
        mov r2, #438
        swi 0

        @Proceso de lectura del archivo

        mov r7, #3
        ldr r1, =ranking_1              //donde poner el cont. leído
        mov r2, #250
        swi 0

        @cerrar el archivo
        mov r0, r6
        mov r7, #6
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend


agregarJugadorARanking:
.fnstart
        push {r1,r2,r3,lr}
        ldr r1, =nombreJugador
        ldr r3, =ranking_2

        cicloAgregarJugador:
        ldrb r2, [r1]
        cmp r2, #0
        beq agregarPuntaje
        strb r2, [r3]
        add r1, #1
        add r3, #1
        bal cicloAgregarJugador

        agregarPuntaje:
        mov r2, #0x20                   //espacio
        strb r2, [r3]
        add r3, #1
        ldr r1, =vidasJugadorTexto
        ldr r2, [r1]
        str r2, [r3]
        add r3, #2
        ldr r1, =ranking_1
        mov r4, #0                              //contar la cantidad de saltos de lineas

        cicloRankingAnterior:
        ldrb r2, [r1]                           //empiezo a cargar los bytes del ranking viejo
        cmp r2, #10                             //identifico salto de linea
        beq siguienteNombre
        strb r2, [r3]
        add r1, #1
        add r3, #1
        bal cicloRankingAnterior

        siguienteNombre:
        strb r2, [r3]
        add r1, #1
        add r3, #1
        add r4, #1
        cmp r4, #2
        beq completarConCeros
        bal cicloRankingAnterior

        completarConCeros:
        mov r2, #0
        strb r2, [r3]
        ldr r1, =ranking_2
        bl calcularCaracteres
        mov r4, #250
        sub r4, r2
        mov r2, #0x20

        escribirCero:
        cmp r4, #0
        beq salirActualizarRanking
        strb r2, [r3]
        add r3, #1
        sub r4, #1
        bal escribirCero

        salirActualizarRanking:
        bl exportarRanking
        pop {r1,r2,r3,lr}
        bx lr
.fnend

exportarRanking:
.fnstart
        push {r0,r1,r2,r6,r7,lr}
        mov r7, #5
        ldr r0, =rankingArchivo         //busca el archivo por el nombre en esta etiq
        mov r1, #1                      //0 lectura, 1 escritura, 2 ambos
        mov r2, #438
        swi 0

        mov r6, r0

        mov r0, r6
        mov r7, #4
        ldr r1, =ranking_2
        mov r2, #250
        sub r2, #1
        swi 0

        @cerrar el archivo
        mov r0, r6
        mov r7, #6
        swi 0
        pop {r0,r1,r2,r6,r7,lr}
        bx lr
.fnend

importarListaDePalabras: .fnstart
        push {r1,r2,r7,lr}
        mov r7, #5              //abre el archivo
        ldr r0, =archivo
        mov r1, #2
        mov r2, #438
        swi 0

        mov r7, #3              //guarda las palabras en bufferLemario separadas por salto de linea
        ldr r1, =palabras
        mov r2, #200
        swi 0

        mov r0, r6
        mov r7, #6
        swi 0
        pop  {r1,r2,r7,lr}
        bx lr
.fnend

random:
.fnstart
        push {r1,r2,r7,lr}
        mov r7, #384
        ldr r0, =semilla
        mov r1, #4
        mov r2, #0
        swi 0
        ldr r1, =semilla
        ldr r0, [r1]
        and r0, r0, #15
        str r0, [r1]
        pop  {r1,r2,r7,lr}
        bx lr
.fnend

ingresarLetra:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =letraIngresada
        mov r2, #10
        mov r7, #3
        swi 0
        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

ingresarCoordenadaX:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =coorXingresada
        mov r2, #3
        mov r7, #3
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

ingresarCoordenadaY:
.fnstart
        push {r0,r1,r2,r7,lr}
        mov r0, #0
        ldr r1, =coorYingresada
        mov r2, #3
        mov r7, #3
        swi 0

        pop {r0,r1,r2,r7,lr}
        bx lr
.fnend

calcularCaracteres:
@cuenta la cantidad de caracteres que tiene una cadena incluyendo el salto de linea. Termina con el 0
@cadena apuntada con r1
@salida en r2
.fnstart
        push {r1,r3,lr}  @guardo los valores excepto la respuesta que necesito de esta subrutina
        mov r2, #0      @r2 va a ser mi contador, como necesito el valor no lo meto en el stack.

        ciclo:
        ldrb r3, [r1]           @cargo 1 byte
        cmp r3, #0              @1er comp del caracter con el inmediato 0
        beq finCaracteres       @compara los ultimos dos valoes para ver si es el final, -condicional

        add r2, #1              @incrementador del contador
        add r1, #1              @incrementador de bytes
        bal ciclo

        finCaracteres:
        pop {r1,r3,lr}
        bx lr                   @regreso
.fnend


imprimir:               @imprime r1
.fnstart
        push {r0,r7,lr}
        mov r0, #1              @info imprimir 1
        mov r7, #4              @info imprimir 2
        bl calcularCaracteres
        swi 0

        pop {r0,r7,lr}          @si falla aca le tengo que volver a poner el r2 y probar.
        bx lr

.fnend


.global main
main:

        bl importarListaDePalabras
        bl seleccionarPalabra
        bl reiniciarAvance
        bl dibujarTitulo
        bl obtenerNombreDeJugador
        bl preguntarVerRanking


        juegoA:
        bl dibujarHorca
        bl mostrarVidas
        bl mostrarJugadorActual
        ldr r1, =pedirLetra
        bl imprimir
        ldr r1, =avanceJugador
        bl imprimir

        bl ingresarLetra                        //r1 letra escrita (input)
        bl analizarIngreso                      //analizar si la letra es valida viendo si esta en incognita y se actualiza el bool
        bl actualizarVidas
        bl reemplazarLetraEnAvanceJugador       //se reemplaza la letra en avanceJugador
        bl comprobarDerrota
        bl comprobarVictoria

        ldr r0, =boolJugandoA
        ldrb r0, [r0]
        cmp r0, #1
        beq juegoA

        gameOver:

        mov r7, #1                      @fin del programa
        swi 0