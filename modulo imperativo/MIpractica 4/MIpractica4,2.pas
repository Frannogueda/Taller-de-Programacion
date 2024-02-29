program eje;
	type
		RangoMes=1..12;
		RangoDia=1..30;
		prestamo=record
			isbn:integer;
			numSocio:integer;
			dia:RangoDia;
			mes:RangoMes;
			cantDias:integer;
		end;
		prestamo_2=record
			Isbn:integer;
			numeroSocio:integer;
			cantidadDias:integer;
		end;
		Isbn_presta=record
			ISBN:integer;
			TotalDP:integer;
		end;
		arbol=^nodo;
		nodo=record
			dato:prestamo;
			HI:arbol;
			HD:arbol;
		end;
		arbol_2=^registro;
		registro=record
			dato:prestamo_2;
			HI:arbol_2;
			HD:arbol_2;
		end;
		lista=^presta;
		presta=record
			dato:Isbn_presta;
			sig:lista;
		end;
	procedure CargarArboles(var a1:arbol; var a2:arbol_2);
		procedure leerPrestamo(var p:prestamo);
			begin
				writeln('ingrese el isbn: '); readln(p.isbn);
				if(p.isbn<>-1)then begin
					p.numSocio:=random(200);
					p.dia:=random(29);
					p.Mes:=random(12);
					p.cantDias:=random(50);
				end;
			end;
		procedure crearArbol_1(var a:arbol; p:prestamo);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=p;
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(a^.dato.isbn>=p.isbn)then 
							crearArbol_1(a^.HI,p)
							else
								crearArbol_1(a^.HD,p)
			end;
		procedure crearArbol_2(var a:arbol_2; p:prestamo);
			procedure convertirDato(p:prestamo; var p2:prestamo_2);
				begin
					p2.Isbn:=p.isbn;
					p2.numeroSocio:=p.numSocio;
					p2.cantidadDias:=p.cantDias;
				end;
			var
				p2:prestamo_2;
			begin
				if(a=nil)then begin
					new(a);
					convertirDato(p,p2);
					a^.dato:=p2;
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(a^.dato.Isbn=p.isbn)then
							a^.dato.cantidadDias:=a^.dato.cantidadDias+p.cantDias
							else
								if(a^.dato.Isbn>p2.Isbn)then
									crearArbol_2(a^.HD,p)
								else
									crearArbol_2(a^.HI,p);
			end;
		var
			p:prestamo;
		begin
			a1:=nil; a2:=nil;
			leerPrestamo(p);
			while(p.isbn<>-1)do begin
				crearArbol_1(a1,p);
				crearArbol_2(a2,p);
				leerPrestamo(p);
				end;
		end;
	function MaxIbsn(a:arbol):integer;
		begin
			if(a^.HD=nil)then
				MaxIbsn:=a^.dato.isbn
				else 
					MaxIbsn:=MaxIbsn(a^.HD)
		end;
	function MinIbsn(a:arbol_2):integer;
		begin
			if(a^.HI=nil)then
				MinIbsn:=a^.dato.Isbn
				else 
					MinIbsn:=MinIbsn(a^.HD)
		end;
	procedure imprimirSocio(a:arbol);
		begin
			if(a<>nil)then begin
				imprimirSocio(a^.HI);
				writeln('el numero del socio es: ',a^.dato.numSocio);
				writeln('y los dias de prestamo fueron: ',a^.dato.cantDias);
				imprimirSocio(a^.HD);
			end;
		end;
	function Busqueda(a:arbol; x:integer):integer;
		begin
			if(a=nil)then
				Busqueda:=0
				else
					if(a^.dato.numSocio=x)then
						Busqueda:=a^.dato.cantDias
					else
						begin
							Busqueda:=Busqueda(a^.HI,x);
							if(Busqueda=0)then
								Busqueda:=Busqueda(a^.HD,x);
			end;
		end;
	function Busqueda(a:arbol_2; x:integer):integer;
		begin
			if(a=nil)then
				Busqueda:=0
				else
					if(a^.dato.numeroSocio=x)then
						Busqueda:=a^.dato.cantidadDias
					else
						begin
							Busqueda:=Busqueda(a^.HI,x);
							if(Busqueda=0)then
								Busqueda:=Busqueda(a^.HD,x);
			end;
		end;
	procedure cargarPrimeraLista(a:arbol; var l:lista);
		procedure cargarNodo(var l:lista; isbn:integer; cant:integer);
			var
				nue,act,ant:lista;
			begin
				new(nue);
				nue^.dato.ISBN:=isbn;
				nue^.dato.TotalDP:=cant;
				act:=l;
				ant:=l;
				while(act<>nil)and(act^.dato.ISBN<=isbn)do begin
					ant:=act;
					act:=act^.sig;
					end;
						if(act=ant)then
							l:=nue
							else
								ant^.sig:=nue;
							nue^.sig:=act;
			end;
		begin
			if(a<>nil)then begin
				cargarPrimeraLista(a^.HI,l);
				cargarNodo(l,a^.dato.isbn,a^.dato.cantDias);
				cargarPrimeraLista(a^.HD,l);
			end;
		end;
	procedure cargarSegundaLista(a:arbol_2; var l:lista);
		procedure cargarNodo(var l:lista; isbn:integer; cant:integer);
			var
				nue,act,ant:lista;
			begin
				new(nue);
				nue^.dato.ISBN:=isbn;
				nue^.dato.TotalDP:=cant;
				act:=l;
				ant:=l;
				while(act<>nil)and(act^.dato.ISBN<isbn)do begin
					ant:=act;
					act:=act^.sig;
					end;
						if(act=ant)then
							l:=nue
							else
								ant^.sig:=nue;
							nue^.sig:=act;
			end;
		begin
			if(a<>nil)then begin
				cargarSegundaLista(a^.HI,l);
				cargarNodo(l,a^.dato.Isbn,a^.dato.cantidadDias);
				cargarSegundaLista(a^.HD,l);
			end;
		end;
	procedure imprimi(l:lista);
		begin
			while(l<>NIL)do begin
				writeln('el isbn es: ',l^.dato.ISBN);
				l:=l^.sig;
			end;
		end;
	procedure imprimi(l:lista);
		begin
			while(l<>NIL)do begin
				writeln('el isbn es: ',l^.dato.ISBN);
				l:=l^.sig;
			end;
		end;
		
	var
		a1:arbol; a2:arbol_2; x:integer; L1,L2:lista;
	begin
		L1:=nil; L2:=nil;
		randomize;
		CargarArboles(a1,a2);{Inciso A}{preguntar por el seg arbol si esta bien}
		writeln('el Ibsn mas grande fue: ',MaxIbsn(a1));{Inciso B}
		writeln('el Ibsn mas chico fue: ',MinIbsn(a2));{Inciso C}
		imprimirSocio(a1);
		writeln('ingrese un valor de ibsn a buscar: '); readln(x);
		writeln('la cantidad de prestamos que tuve el socio fue de: ',Busqueda(a1,x));{Inciso D}
		writeln('la cantidad de prestamos que tuve el socio fue de: ',Busqueda(a2,x));{Inciso E}
		cargarPrimeraLista(a1,L1);{Inciso F}
		cargarSegundaLista(a2,L2);{Inciso G}
		imprimi(L1);
		imprimi(L2);
		{ultimos dos incisos de buscar valores entre dos codigos}
	end.
