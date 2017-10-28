public class Desafio
{
	public static void main(String[] args) {
		byte max_byte_value = 0; // byte com valor 0
		float represent_0 = Float.MAX_VALUE;

		String s1;

		/* Overflow de byte
		um teste simples para que possámos observar 
		até onde a variável byte consegue ir no espectro positivo.
		*/
		while (max_byte_value > -1){
			max_byte_value++;

			//formatação para mostrar valor em binario pego em https://stackoverflow.com/questions/12310017/how-to-convert-a-byte-to-its-binary-string-representation
			System.out.print("INT: "+max_byte_value+" --- BINARY: "+String.format("%8s", Integer.toBinaryString(max_byte_value & 0xFF)).replace(' ', '0')+"\n");
		}

		System.out.print("Podemos observar que a variável, ao exceder 127, se torna negativa.\nIsso acontece porque byte é uma variável de apenas 8 bits com sinal.Quando acontece o overflow, ela tem representação trocada por complemento de 2 e se torna -128\n");

		/* Underflow de byte
		Como, em java, bytes são sempre signed, mostraremos como o underflow ocorre.
		*/

		max_byte_value = 0;
		while (max_byte_value <= 0){
			max_byte_value--;

			//formatação para mostrar valor em binario pego em https://stackoverflow.com/questions/12310017/how-to-convert-a-byte-to-its-binary-string-representation
			System.out.print("INT: "+max_byte_value+" --- BINARY: "+String.format("%8s", Integer.toBinaryString(max_byte_value & 0xFF)).replace(' ', '0')+"\n");
		}

		System.out.print("De forma similar ao overflow, o underflow faz com que a representação seja trocada pelo limite contrário, neste caso +127\n");

		/* Representação do 0 com float

		*/
		while (represent_0 != 0.0){
			represent_0 *= 0.1;

			System.out.print("Float: "+represent_0+"\n");
		}

		System.out.print("Podemos ver que Java tem precisao de Expoente = -46 casas decimais para então representar o 0.\n");

	}
}