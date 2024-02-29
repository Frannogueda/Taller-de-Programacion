{Un psicologo necesita un sistema para administrar a sus pacientes.
	de cada paciente se lee:dni,cod de paciente,obra social(1 a 5) y el costo abonado por sesion.
	implementa un programa que:
	a)genere un ABB ordenado por dni.Para ello,genere imformacion hasta el paciente 0.(sera el codigo)
		apartir del arbol hacer:
	b)generar una estructura con dni y cod paciente de los paciente de ioma(1),ordenados
		por dni de forma descentente
	c)dado un dni,modificar la obra social de dicho paciente a un recibida.
		considerar que el paciente puede no existir.
	NOTA:realice el programa principal que invoque los modulos desarrolados.}

program parcial;
	type
		Rango=1..5;
		paciente=record 
			dni:integer;
			codP:integer;
			Obra:Rango;
			costo:real;
		end;
		Pioma=record
			Dni:integer;
			cod:integer;
		end;
		arbol=^nodo;
		nodo=record
			dato:paciente;
			HD:arbol;
			HI:arbol;
		end;
		lista=^nodoL;
		nodoL=record
			dato:PIoma;
			sig:lista;
		end;
	procedure cargarDatos(var a:arbol);
		procedure leerPaciente(var p:paciente);
			begin
				readln(p.codP);
				if(p.codP<>0)then begin
					readln(p.dni);
					readln(p.Obra);
					readln(p.costo);
				end;
			end;
		procedure CargarArbol(var a:arbol; p:paciente);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=p;
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(p.dni>a^.dato.dni)then
							CargarArbol(a^.HD,p)
							else
								CargarArbol(a^.HI,p)
			end;
		var
			p:paciente;
		begin
			a:=nil;
			leerPaciente(p);
			while(p.codP<>0)do begin
				CargarArbol(a,p);
				leerPaciente(p);
			end;
		end;
	procedure cargarLista(a:arbol; var l:lista);
		procedure crearNodo(var l:lista; dni,cod:integer);
			var
				aux:lista;
			begin
				new(aux);
				aux^.dato.dni:=dni;
				aux^.dato.cod:=cod;
				aux^.sig:=l;
				l:=aux;
			end;
		begin
			if(a<>nil)then begin
				cargarLista(a^.HI,l);
				if(a^.dato.Obra=1)then
					crearNodo(l,a^.dato.dni,a^.dato.codP);
				cargarLista(a^.HD,l);
			end;
		end;
	function Modifica(a:arbol; dni,obra:integer):boolean;
		begin
			if(a=nil)then
				Modifica:=false
				else
					if(a^.dato.dni=dni)then begin
						a^.dato.Obra:=obra;
						Modifica:=true;
						end
						else
							if(dni>a^.dato.dni)then
								Modifica:=Modifica(a^.HD,dni,obra)
								else
									Modifica:=Modifica(a^.HI,dni,obra)
		end;
	var
		a:arbol; l:lista; dniB,obraB:integer;
	begin
		l:=nil;
		cargarDatos(a);{Inciso A}
		cargarLista(a,l);{Inciso B}
		readln(dniB); readln(obraB);
		if(Modifica(a,dniB,obraB)=true)then{Inciso C}
			writeln('se modifico la obra del paciente')
			else
				writeln('no hay ningun paciente a modificar');
	end.
