program eje;
	type
		Rango=2010..2018;
		auto_guardar=record
			anio:Rango;
			patente:integer;
			modelo:string;
		end;
		auto=record
			marca:string;
			otros:auto_guardar;
		end;
		autito=record
			marca:string;
			anio:Rango;
			patente:integer;
			modelo:string;
		end;
		arbol=^nodo;
		nodo=record
			dato:auto;
			HD:arbol;
			HI:arbol;
		end;
		lista=^L_auto;
		L_auto=record
			dato:auto_guardar;
			sig:lista;
		end;
		arbol_1=^nodo2;
		nodo2=record
			marca:string;
			pri:lista;
			HI:arbol_1;
			HD:arbol_1;
		end;
		listaAnio=^nodo_1;
			nodo_1=record
			dato:autito;
			sig:listaAnio;
		end;
	
	procedure cargarArboles(var a1:arbol; var a2:arbol_1);
		procedure leerAuto(var a:auto);
			begin
				readln(a.marca);
				if(a.marca<>'aa')then begin
					readln(a.otros.anio);
					readln(a.otros.patente);
					readln(a.otros.modelo);
				end;
			end;
		procedure crearArbol(var a:arbol; aut:auto);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=aut;
					a^.HI:=nil;
					a^.HD:=nil;
				end
					else
						if(a^.dato.otros.patente<=aut.otros.patente)then
							crearArbol(a^.HI,aut)
							else
								crearArbol(a^.HD,aut);
			end;
		procedure crearArbol_1(var a:arbol_1; aut:auto);
			procedure crearNodo(var l:lista; a:auto_guardar);
				var
					aux:lista;
				begin
					new(aux);
					aux^.dato:=a;
					aux^.sig:=l;
					l:=aux;
				end;
			begin
				if(a=nil)then begin
					new(a);
					a^.marca:=aut.marca;
					a^.pri:=nil;
					crearNodo(a^.pri,aut.otros);
					a^.HD:=nil;
					a^.HI:=nil;
					end
					else
						if(a^.marca=aut.marca)then
							crearNodo(a^.pri,aut.otros)
							else
								if(a^.marca<aut.marca)then
									crearArbol_1(a^.HI,aut)
									else
										crearArbol_1(a^.HD,aut);
			end;
		var
			a:auto;
		begin
			leerAuto(a);
			while(a.marca<>'aa')do begin
				crearArbol(a1,a);
				crearArbol_1(a2,a);
				leerAuto(a);
			end;
		end;
	procedure BusquedaMarca(a:arbol; x:string; var cant:integer);
		begin
			if(a<>nil)then begin
				if(a^.dato.marca=x)then
					cant:=cant+1;
				BusquedaMarca(a^.HI,x,cant);
				BusquedaMarca(a^.HD,x,cant);
			end;
		end;
	procedure BusquedaMarca2(a:arbol_1; y:string; cant:integer);
		function cantidad(l:lista):integer;
			var
				cant:integer;
			begin
				cant:=0;
				while(l<>nil) do begin
					cant:=cant+1;
					l:=l^.sig;
				end;
				cantidad:=cant;
			end;
		begin
			if(a<>nil)then begin
				if(a^.marca=y)then
					cant:=cantidad(a^.pri)
				else
					if(y>a^.marca)then
						BusquedaMarca2(a^.HD,y,cant)
						else
							BusquedaMarca2(a^.HI,y,cant)
			end;
		end;
	procedure AgrupadosPorAnio(a:arbol; var l:listaAnio);
		procedure Convertir(marca:string; a:auto_guardar; var auti:autito);
			begin
				auti.marca:=marca;
				auti.anio:=a.anio;
				auti.patente:=a.patente;
				auti.modelo:=a.modelo;
			end;
		procedure InsertarOrdenado(a:autito; var l:listaAnio);
			var
				aux,act,ant:listaAnio;
			begin
				new(aux);
				aux^.dato:=a;
				act:=l;
				ant:=l;
				while(act<>nil)and(aux^.dato.anio<a.anio)do begin
					ant:=act;
					act:=act^.sig;
				end;
					if(act=ant)then
						l:=aux
						else
							ant^.sig:=aux;
						aux^.sig:=act;
			end;
		var
			auti:autito;
		begin
			if(a<>nil)then begin
				AgrupadosPorAnio(a^.HD,l);
				AgrupadosPorAnio(a^.HI,l);
				Convertir(a^.dato.marca,a^.dato.otros,auti);
				InsertarOrdenado(auti,l);
			end;
		end;
	function BusquedaPatenteA1(a:arbol; pate:integer):string;
		begin
			if(a=nil)then
				BusquedaPatenteA1:='nada'
				else
					if(a^.dato.otros.patente=pate)then
						BusquedaPatenteA1:=a^.dato.otros.modelo
						else
							if(pate>a^.dato.otros.patente)then
								BusquedaPatenteA1:=BusquedaPatenteA1(a^.HD,pate)
								else
									BusquedaPatenteA1:=BusquedaPatenteA1(a^.HI,pate)
		end;
	function BusquedaPatenteA2(a:arbol_1; pate:integer):string;
		procedure BuscarL(l:lista; pate:integer; var mAux:string; var pAux:integer);
			begin
				while(l<>nil)do begin
					if(l^.dato.patente=pate)then begin
						pAux:=l^.dato.patente;
						mAux:=l^.dato.modelo;
						end
						else
							l:=l^.sig;
				end;
			end;
		var
			ModeloAux:string; PateAux:integer;
		begin
			if(a=nil)then
				BusquedaPatenteA2:='nada'
				else
					BuscarL(a^.pri,pate,ModeloAux,PateAux);
					if(PateAux=pate)then
						BusquedaPatenteA2:=ModeloAux
						else
							BusquedaPatenteA2:=BusquedaPatenteA2(a^.HI,pate);
							BusquedaPatenteA2:=BusquedaPatenteA2(a^.HD,pate);
		end;
	
	var
		arbolPatente:arbol; arbolMarca:arbol_1; x,y,MBPorPatente,MBPorPatente1:string;
		cant,cant1,Patente1,Patente2:integer; l:listaAnio;
	begin
		cant:=0; cant1:=0; arbolPatente:=nil; arbolMarca:=nil; l:=nil;
		cargarArboles(arbolPatente,arbolMarca);{Inciso A}
		writeln('ingrese la marca a buscar: '); readln(x);
		BusquedaMarca(arbolPatente,x,cant);
		writeln('la cantidad de autos que hay es: ',cant);{Inciso B}
		writeln('ingrese la marca a buscar: '); readln(y);
		BusquedaMarca2(arbolMarca,y,cant);
		writeln('la cantidad de autos que hay es: ',cant1);{Inciso C}
		AgrupadosPorAnio(arbolPatente,l);{Inciso D}
		readln(Patente1);
		MBPorPatente:=BusquedaPatenteA1(arbolPatente,Patente1);{Inciso E}
		readln(Patente2);
		MBPorPatente1:=BusquedaPatenteA2(arbolMarca,Patente2);{Inciso F}
		{el programa no se probo xd. pero compila bien}
	end.
