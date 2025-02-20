// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins
/*
switch (n_pant) {
    // nariz
    case 0:
        if (nariz_despejada == 0 && flags[30] == 33) {
            if (p_tx < 9 && p_ty > 4  && p_ty < 8) {
                // reproduzco sonido
                wyz_play_sound(3);
                // cambio el flag de nariz despejada
                nariz_despejada = 1;
                // recargo la pantalla para mostrarla sin obstaculo
                o_pant = 99;
                // actualizo el texto que se mostrara ahora al entrar
                textos_pantallas[0] = " LA NARIZ AHORA ESTA DESPEJADA  ";
                // suelto el objeto
                flags[30] = 0;
                // muestro el objeto en el inventario
                RedibujaInventario();
                // recargo el texto de la pantalla
                EscribeTextoPantalla();
            }
        }
        break;
}
*/