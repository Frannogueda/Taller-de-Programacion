program eje;
	type
		socio=record
			numero:integer;
			nombre:string;
			edad:integer;
		end;
		arbol=^nodo;
		nodo=record
			dato:socio;
			HI:arbol;
			HD:arbol;
		end;

	procedure cargarDatos(var a:arbol);
		procedure leerSocio(var s:socio);
			begin
				writeln('ingrese el numero del socio: '); readln(s.numero);
				writeln('ingrese el nombre del socio: '); readln(s.nombre);
				writeln('ingrese la edad del socio: '); readln(s.edad);
			end;
		procedure crearArbol(var a:arbol; s:socio);
			begin
				if(a=nil)then begin
					new(a); 
					a^.dato:=s;
					a^.HI:=nil;
					a^.HD:=nil;
				end
				else
					if(s.numero>=a^.dato.numero)then 
					crearArbol(a^.HD,s)
					else
					crearArbol(a^.HI,s);
			end;
		var
			s:socio;
		begin
			a:=nil;
			leerSocio(s);
			while(s.numero<>0)do begin
				crearArbol(a,s);
				leerSocio(s);
			end;
		end;
	procedure SocioMax(a:arbol; var Max:integer);
		begin
			if(a<>nil)then begin
				SocioMax(a^.HD,max);
				if(a^.dato.numero>max)then
					max:=a^.dato.numero;
			end;
		end;
		
	procedure SocioMin(a:arbol; var socioMin:socio; var min:integer);
		begin
			if(a<>nil)then begin
				SocioMin (a^.HI,socioMin,min);
				if(a^.dato.numero<=min)then begin
					socioMin:=a^.dato;
					min:=a^.dato.numero;
				end;
			end;
		end;
	procedure InformarMayorEdad(a:arbol; var eMax:integer);
		begin
			if(a<>nil)then begin
				if(a^.edad>eMax)then
					eMax:=a^.edad
				InformarMayorEdad(a^.HD,eMax);
				InformarMayorEdad(a^.HI,eMax);
			end;
		end;
	procedure Aumentar_1(a:arbol);
		begin
			if(a<>nil)then begin
			Aumentar_1(a^.HI);
			Aumentar_1(a^HD);
			a^.dato.edad:=a^.dato.edad+1;
			end;
		end;
	function buscarNumero(a:arbol; num:integer):boolean;
		var
			encontro:boolean;
		begin
			if(a<>nil)and(not encontro)then begin
				if(a^.dato.edad =num)then
					encontro:=true;
					else
						begin
						buscarNumero(a^.HD,num);
						buscarNumero(a^.HI,num);
						end;
				end;
			buscarNumero:=encontro;
		end;
	function buscarNombre(a:arbol; nombre:string):boolean;
		var
			encontro:boolean;
		begin
			if(a<>nil)and(not encontro)then begin
				if(a^.dato.nombre=nombre)then
					encontro:=true
					else
					buscarNombre(a^.HD,nombre);
					buscarNombre(a^.HI,nombre);
				end;
			end;
	function Numsocios(a:arbol):integer;
		var
			cant:integer;
		begin
			if(a<>nil)then begin
				cant:=cant+Numsocios(a^.HD);
				cant:=cant+Numsocios(a^.HI);
				end;
			Numsocios:=cant;
		end;
	function promEdad(a:arbol):integer;
		var
			sumas:integer;
		begin
			if(a<>nil)then begin
				suma:=suma+promEdad(a^.HD);
				suma:=suma+promEdad(a^.HI);
			end;
			promEdad:=suma;
		end;
	procedure informarSociosCreci(a:arbol);
		begin
			if(a<>nil)then begin
				informarSociosCreci(a^.HI);
				writeln('el numero del socio es: ',a^.dato.numero);
				informarSociosCreci(a^.HD);
			end;
		end;
	procedure informarParesDecre(a:arbol);
		function pares(num:integer):boolean;
			begin
				if((num mod 2)=0)then
					pares:=true
					else
							pares:=false;
			end;
		begin
			if(a<>nil)then begin
				informarParesDecre(a^.HD);
				informarParesDecre(a^.HI);
				if(pares=true)then
					writeln('el numero: ',a^.dato.numero,' es par');
				end;
		end;

	var	
		a:arbol; Max,min,eMax,num:integer; socioMin:socio; nombre:string; promedio:real;
	begin
		max:=0; min:=999; eMax:=0;
		cargarDatos(a);{Inciso A}
		SocioMax(a,Max); writeln('el maximo del arbol fue: ',max);{Inciso i}
		SocioMin(a,socioMin,min);writeln('el minimo del arbol fue: ',socioMin){imprimir todo}){Inciso ii}{problemas con un ';' preguntar}
		InformarMayorEdad(a,eMax);writeln('el socio con mayor fue: ',eMax);{Inciso iii}{falta el codigo}
		Aumentar_1(a);{Inciso iv}
		writeln('ingrese un numero a buscar: '); readln(num);
		writeln('el valor fue: ',buscarNumero(a,num));{inciso v)}//cuestionable
		writeln('ingresa un nombre a buscar: '); readln(nombre);
		writeln('el nombre fue: ',buscarNombre(a,nombre);{Inciso vi}//cuestionable
		writeln('la cantidad de socios fue: ',Numsocios(a));{Inciso vii}
		writeln('el promedio de edad es: ',promedio:=promEdad(a))/Numsocios(a));{Inciso viii}
		writeln('la suma de las edades son: ',Numsocios(a));{Inciso E}
		informarSociosCreci(a);{Inciso xi}
		informarParesDecre(a);{Inciso x}
		end.
