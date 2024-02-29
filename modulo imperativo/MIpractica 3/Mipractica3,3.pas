program eje;
	type
		listaN=^nota;
		califi=record
			codigo:integer;
			nota:integer;
		end;
		nota=record
			dato:califi;
			sig:listaN;
		end;
		alumno=record
			legajo:integer;
			dni:integer;
			anioI:integer;
			notas:listaN;
		end;
		AluMenores=record
			Aludni:integer;
			anio:integer;
		end;
		
		arbol=^nodo;
		nodo=record
			dato:alumno;
			HD:arbol;
			HI:arbol;
		end;
		listaAlu=^alu;{lista para informar el Inciso 2}
			alu=record
				dato:AluMenores;
				sig:listaAlu;
			end;
		
	procedure leerAlumno(var a:alumno);
		procedure crearNodo(var l:listaN; codigo:integer; notas:integer);
			var
				nue: listaN;
			begin
				new(nue);
				nue^.dato.codigo:=codigo;
				nue^.dato.nota:=notas;
				nue^.sig := l;
				l:=nue;
		end;
		var
			notas,codigo:integer;
		begin
			a.notas:=nil;
			writeln('codigo del alumno: '); readln(codigo);
			while(codigo<>-1)do begin
				writeln('ingrese la nota: '); readln(notas);
				crearNodo(a.notas,codigo,notas);
				writeln('codigo del alumno: '); readln(codigo);
				end;
				writeln('ingrese el legajo: '); readln(a.legajo); 
				writeln('ingrese el dni: '); readln(a.dni);
				writeln ('anio de ingreso: '); readln(a.anioI); 
		end;
	procedure crearArbol(var a:arbol; alu:alumno);
		begin
			if(a=nil)then begin
				new(a);
				a^.dato:=alu;
				a^.HD:=nil;
				a^.HI:=nil;
				end
				else
					if(alu.legajo>=a^.dato.legajo)then
						crearArbol(a^.HD,alu)
					else
						crearArbol(a^.HI,alu)
				end;
	
	procedure cargarAlumnos(var a:arbol);
		var
			alu:alumno;
		begin
			leerAlumno(alu);
			while(alu.legajo<>0)do begin
				crearArbol(a,alu);
				leerAlumno(alu);
			end;
		end;
	procedure CrearLista(var l:listaAlu; alu:integer; anio:integer);
		var
			aux:listaAlu;
		begin
			new(aux);
			aux^.dato.aludni:=alu;
			aux^.dato.anio:=anio;
			aux^.sig:=nil;
			l:=aux;
		end;
	procedure AluMinimos(a:arbol; var l:listaAlu; valor:integer);
		begin
			if(a<>nil)then begin
				AluMinimos(a^.HI,l,valor);
				AluMinimos(a^.HD,l,valor);
				if(a^.dato.legajo<valor)then 
					CrearLista(l,a^.dato.dni,a^.dato.anioI);
			end;
		end; 
		
	procedure legajoMax(a:arbol; var Max:integer);
		begin
			if(a<>nil)then begin
				legajoMax(a^.HI,Max);
				legajoMax(a^.HD,Max);
				if(a^.dato.legajo>Max)then
					max:=a^.dato.legajo;
		end;
	end;
	
	procedure DniMax(a:arbol; var Max:integer);
		begin
			if(a<>nil)then begin
				DniMax(a^.HI,Max);
				DniMax(a^.HI,Max);
				if(a^.dato.dni>Max)then
					Max:=a^.dato.dni;
			end;
		end;
	procedure LegajoImpar(a:arbol; var cant:integer);
		function impar(num:integer):boolean;
			var
				dig:integer; cumple:boolean;
			begin
			cumple:=true;
			while(num<>0)and(cumple)do begin
					dig:=num mod 10;
					if((dig mod 2)=0)then begin
						impar:=false;
						cumple:=false;
						end
						else
							num:=num div 10
				end;
			impar:=true;
			end;
		begin
			if(a<>nil)then begin
				LegajoImpar(a^.HI,cant);
				LegajoImpar(a^.HD,cant);
				if(impar(a^.dato.legajo)=true)then
					cant:=cant+1;
			end;
		end;
		procedure MejorPromedio(a:arbol; var legaMax:integer; var prom:real);
			function promedio(l:listaN):real;
				var
					cant:integer; notas:integer;
				begin
					cant:=0; notas:=0;
					while(l<>NIl)do begin
						cant:=cant+1;
						notas:=notas+l^.dato.nota;
						l:=l^.sig;
					end;
					promedio:=notas/cant;
				end;
			begin
				if(a<>nil)then begin
					if(promedio(a^.dato.notas)>prom)then begin
						prom:=promedio(a^.dato.notas);
						legaMax:=a^.dato.legajo;
					end;
					MejorPromedio(a^.HI,legaMax,prom);
					MejorPromedio(a^.HD,legaMax,prom);
				end;
			end;
		
	var
		a:arbol; l:listaAlu; valor:integer; lMax:integer; Max:integer;
		legaImpar,legaMaximo:integer; promM:real;
	begin
		a:=nil; l:=nil; lMax:=0; Max:=0; legaImpar:=0; legaMaximo:=0;
		promM:=0;
		cargarAlumnos(a);{Inciso A}{problema con la lectura de las notas}
		writeln('ingrese el valor: '); readln(valor); 
		AluMinimos(a,l,valor);{Inciso B}{dsp se puede imprimir l para ver los menores}
		legajoMax(a,lMax);
		writeln('el legajo mas grande fue: ',lMax);{Inciso C}
		DniMax(a,Max);
		writeln('el dni mas grande fue: ',Max);{Inciso D}
		LegajoImpar(a,legaImpar);
		writeln('la cantidad de alumnos con legajo impar fueron: ',legaImpar);{Inciso E}
		MejorPromedio(a,legaMaximo,promM);
		writeln('el el legajo: ',legaMaximo,' tuvo el promedio de: ',promM:2:2,' y fue el mejor');{Inciso E.2}
		{falta el ult Inciso, dio paja}
	end.
