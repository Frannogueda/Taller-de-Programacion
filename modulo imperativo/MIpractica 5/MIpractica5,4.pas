program eje;
	type
		reclamo=record
			anio:integer;
			codigo:integer;
			Treclamo:string;
		end;
		lista=^nodo;
		nodo=record
			dato:reclamo;
			sig:lista;
		end;
		arbol=^nodoA;
		nodoA=record
			dni:integer;
			dato:lista;
			HD:arbol;
			HI:arbol;
		end;
		listaA=^nodoAnio;
		nodoAnio=record
			codigos:integer;
			sig:listaA;
		end;
	procedure cargarDatos(var a:arbol);
		procedure leerReclamo(var r:reclamo);
			begin
				readln(r.codigo);
				if(r.codigo<>-1)then begin
					readln(r.anio);
					readln(r.Treclamo);
				end;
			end;
		procedure cargarArbol(var a:arbol; r:reclamo; dni:integer);
			procedure crearNodo(var l:lista; r:reclamo);
				var
					aux:lista;
				begin
					new(aux);
					aux^.dato:=r;
					aux^.sig:=l;
					l:=aux;
				end;
			begin
				if(a=nil)then begin
					new(a);
					a^.dni:=dni;
					a^.dato:=nil;
					crearNodo(a^.dato,r);
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(a^.dni=dni)then
							crearNodo(a^.dato,r)
							else
								if(a^.dni>dni)then
									cargarArbol(a^.HI,r,dni)
									else
										cargarArbol(a^.HD,r,dni)
			end;
		var
			r:reclamo; dni:integer;
		begin
			leerReclamo(r);
			readln(dni);
			while(r.codigo<>-1)do begin
				cargarArbol(a,r,dni);
				leerReclamo(r);
				readln(dni);
			end;
		end;
		
	function contador(l:lista):integer;
			var
				cant:integer;
			begin
				cant:=0;
				while(l<>nil)do begin
					cant:=cant+1;
					l:=l^.sig;
				end;
				contador:=cant;
			end;
	function CReclamos(a:arbol; dniB:integer):integer;
		begin
			if(a=nil)then
				CReclamos:=0
				else
					if(a^.dni=dniB)then
						CReclamos:=contador(a^.dato)
						else
							if(a^.dni>dniB)then
								CReclamos:=CReclamos(a^.HI,dniB)
								else
									CReclamos:=CReclamos(a^.HD,dniB)
		end;
	function DosDniReclamos(a:arbol; dni1,dni2:integer):integer;
		begin
			if(a<>nil)then
				if(a^.dni>dni1)then
					if(a^.dni<dni2)then
						DosDniReclamos:=contador(a^.dato)+DosDniReclamos(a^.HI,dni1,dni2)+DosDniReclamos(a^.HD,dni1,dni2)
					else
						DosDniReclamos:=DosDniReclamos(a^.HI,dni1,dni2)
				else
					DosDniReclamos:=DosDniReclamos(a^.HD,dni1,dni2)
		end;
	procedure AniosBuscadoL(a:arbol; anioB:integer; var l:listaA);
		procedure recorreL(l:lista; anioB:integer; var l2:listaA);
			procedure crearNodoAnios(var l:listaA; cod:integer);
				var
					aux:listaA;
				begin
					new(aux);
					aux^.codigos:=cod;
					aux^.sig:=l;
					l:=aux;
				end;
			begin
				while(l<>nil)do begin
					if(l^.dato.anio=anioB)then
						crearNodoAnios(l2,l^.dato.codigo);
					l:=l^.sig;
				end;
			end;
		begin
			if(a<>nil)then begin
				recorreL(a^.dato,anioB,l);
				AniosBuscadoL(a^.HD,anioB,l);
				AniosBuscadoL(a^.HI,anioB,l);
			end;
		end;
	var
		a:arbol; dniB,dni1,dni2,anioB:integer; l:listaA;
	begin
		cargarDatos(a);{Inciso A}
		writeln('ingrese el dni a buscar: '); readln(dniB);
		writeln('la cantidad de reclamos que tiene el dni son de: ',CReclamos(a,dniB));{Inciso B}
		writeln('ingrese el dni inferior: '); readln(dni1);
		writeln('ingrese el dni superior: '); readln(dni2);
		writeln('la cantidad de reclamos que hay entre los dnis son: ',DosDniReclamos(a,dni1,dni2));{Inciso C}
		readln(anioB);
		AniosBuscadoL(a,anioB,l);{Inciso D}
	end.
			
