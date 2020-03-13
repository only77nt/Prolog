:- dynamic cat/3.
:- dynamic shortWool/1.
:- dynamic longWool/1.
:- dynamic withoutWool/1.
:- dynamic home/1.
:- dynamic wild/1.
:- dynamic lopEar/1.
:- dynamic specialEar/1.
:- dynamic brushesEar/1.
:- dynamic thinTail/1.
:- dynamic shortTail/1.
:- dynamic fluffyTail/1.
:- dynamic pawPadColor/2. 
:- dynamic differentEyes/1.
:- dynamic shortPaws/1.
:- dynamic bigSize/1.
:- dynamic orangeEyes/1.
:- dynamic blueEyes/1.

%===Все свойства и классы указаны на схеме онтологии===
%===Породы кошек: британская(1),шотландская(2),персидская(3),европейская(4),пуделькэт(5*),домашняя(6*),эльф(7),керл(8),мейнкун(9),бобтейл(10),бамбино(11*),сфинкс(12),норвежскийлеснойкот(13*),мэнская(14*),манчкин(15)===
%===Звёздочка(*) рядом с номером породы означает, что её нет в базе данных, но возможно вывести и добавить туда, скрестив две определённые породы кошек===
%===Свойства: длина шерсти(1), домашняя или дикая(2), форма щёк(3), форма ушей(4), форма хвоста(5), цвет подушечек лап(6), цвет глаз(7), длина лап(8), размер тела(9), возраст(10), вес(11), место происхождения породы(12)===

%======БазаДанных=============================================================
cat(британская, 9, 12).
cat(шотландская, 4, 6).
cat(персидская, 3, 11).
cat(европейская, 4, 5).
cat(эльф, 5, 3).
cat(керл, 7, 10).
cat(мейнкун, 8, 9).
cat(бобтейл, 3, 5).
cat(сфинкс, 2, 2).
cat(манчкин, 5, 4).
%===
shortWool(британская).
shortWool(шотландская).
shortWool(европейская).
shortWool(керл).
shortWool(бобтейл).
shortWool(манчкин).

longWool(мейнкун).
longWool(персидская).

withoutWool(эльф).
withoutWool(сфинкс).
%===
home(британская).
home(шотландская).
home(персидская).
home(эльф).
home(керл).
home(бобтейл).
home(сфинкс).
home(манчкин).

wild(европейская).
wild(мейнкун).
%===
lopEar(шотландская).

specialEar(эльф).
specialEar(керл).

brushesEar(мейнкун).
%===
thinTail(сфинкс).

shortTail(керл).
shortTail(бобтейл).

fluffyTail(мейнкун).
fluffyTail(персидская).
%===
pawPadColor(британская, серыеподушечкилап).
pawPadColor(сфинкс, чёрныеподушечкилап).
pawPadColor(эльф, чёрныеподушечкилап).
%===
orangeEyes(европейская).

blueEyes(пуделькэт).

differentEyes(манчкин).
%===
shortPaws(манчкин).
%===
bigSize(мейнкун).
bigSize(британская).
bigSize(шотландская).
bigSize(персидская).

%======Программа==============================================================

%===Функция поиска всех свойств===
find(X, ObjProp, ClassProp, Res) :- woolClass(X, ObjProp, ClassProp, Res).

%===Класс по типу шерсти===
woolClass(X, _, _, Res) :- longWool(X), homeClass(X, [длиннаяшерсть], [типшерсти], Res).
woolClass(X, _, _, Res) :- shortWool(X), homeClass(X, [короткаяшерсть], [типшерсти], Res).
woolClass(X, _, _, Res) :- withoutWool(X), originClass(X, [безшерсти], [типшерсти], Res).
woolClass(X, _, _, Res) :- not(longWool(X)),not(shortWool(X)),not(withoutWool(X)), homeClass(X, [[длиннаяшерсть, короткаяшерсть,безшерсти]], [типшерсти], Res).

woolClass(класстипшерсти, _, ClassProp, _) :- ClassProp = [типшерсти].
woolClass(объекттипшерсти, ObjProp, _, _) :- ObjProp = [[длиннаяшерсть, короткаяшерсть, безшерсти]].

%===Класс обитания===
homeClass(классобитания, _, ClassProp, Res) :- !, append(ClassProp, местообитания, Res).
homeClass(объектобитания, ObjProp, _, Res) :- !, append(ObjProp, [[домашняя, дикая]], Res).

homeClass(X, ObjProp, ClassProp, Res) :- home(X), originClass(X, [домашняя|ObjProp], [местообитания|ClassProp], Res).
homeClass(X, ObjProp, ClassProp, Res) :- wild(X), originClass(X, [дикая|ObjProp], [местообитания|ClassProp], Res).

homeClass(X, ObjProp, ClassProp, Res) :- not(home(X)), not(wild(X)), originClass(X, [[домашняя, дикая]|ObjProp], [местообитания|ClassProp], Res).

%===Класс по происхождению===
originClass(класспроисхождения, _, ClassProp, Res) :- !, append(ClassProp, [происхождение], Res).
originClass(объектпроисхождения, ObjProp, _, Res) :- !, append(ObjProp, [[европа, скандинавия, африка]], Res).

originClass(X, ObjProp, ClassProp, Res) :- lopEar(X), member(короткаяшерсть, ObjProp), pawPadColorClass(X, [скандинавия|ObjProp], [происхождение|ClassProp], Res).
originClass(X, ObjProp, ClassProp, Res) :- member(длиннаяшерсть, ObjProp), pawPadColorClass(X, [европа|ObjProp], [происхождение|ClassProp], Res).
originClass(X, ObjProp, ClassProp, Res) :- not(lopEar(X)), member(короткаяшерсть, ObjProp), pawPadColorClass(X, [европа|ObjProp], [происхождение|ClassProp], Res). 
originClass(X, ObjProp, ClassProp, Res) :- member(безшерсти, ObjProp), pawPadColorClass(X, [африка|ObjProp], [происхождение|ClassProp], Res).

originClass(X, ObjProp, ClassProp, Res) :- not(member(короткаяшерсть, ObjProp)),not(member(длиннаяшерсть, ObjProp)),not(member(безшерсти, ObjProp)), pawPadColorClass(X, [[скандинавия, европа, африка]|ObjProp], [происхождение|ClassProp], Res).

%===Класс по цвету подушечек лап===
pawPadColorClass(классцветаподушечеклап, _, ClassProp, Res) :- !, append(ClassProp, [цветподушечеклап], Res).
pawPadColorClass(объектцветаподушечеклап, ObjProp, _, Res) :- !, append(ObjProp, [[серыеподушечкилап, чёрныеподушечкилап, розовыеподушечкилап]], Res).

pawPadColorClass(X, ObjProp, ClassProp, Res) :- pawPadColor(X, Color), !, earClass(X, [Color|ObjProp], [цветподушечеклап|ClassProp], Res).
pawPadColorClass(X, ObjProp, ClassProp, Res) :- earClass(X, [розовыеподушечкилап|ObjProp], [цветподушечеклап|ClassProp], Res).

%===Класс по форме ушей===
earClass(классформыушей, _, ClassProp, Res) :- !, append(ClassProp, [формаушей], Res).
earClass(объектформыушей, ObjProp, _, Res) :- !, append(ObjProp, [[вислоухая, специальнаяформаушей, кисточкинаушах, обычныеуши]], Res).

earClass(X, ObjProp, ClassProp, Res) :- specialEar(X), tailClass(X, [специальнаяформаушей|ObjProp], [формаушей|ClassProp], Res).
earClass(X, ObjProp, ClassProp, Res) :- brushesEar(X), tailClass(X, [кисточкинаушах|ObjProp], [формаушей|ClassProp], Res).
earClass(X, ObjProp, ClassProp, Res) :- lopEar(X), tailClass(X, [вислоухая|ObjProp], [формаушей|ClassProp], Res).
earClass(X, ObjProp, ClassProp, Res) :- not(lopEar(X)), not(specialEar(X)), not(brushesEar(X)), tailClass(X, [обычныеуши|ObjProp], [формаушей|ClassProp], Res).

%===Класс по форме хвоста===
tailClass(классформыхвоста, _, ClassProp, Res) :- !, append(ClassProp, [формахвоста], Res).
tailClass(объектформыхвоста, ObjProp, _, Res) :- !, append(ObjProp, [[тонкийхвост, пушистыйхвост, короткийхвост, обычныйхвост]], Res).

tailClass(X, ObjProp, ClassProp, Res) :- thinTail(X), !, pawSizeClass(X, [тонкийхвост|ObjProp], [формахвоста|ClassProp], Res).
tailClass(X, ObjProp, ClassProp, Res) :- shortTail(X), !, pawSizeClass(X, [короткийхвост|ObjProp], [формахвоста|ClassProp], Res).
tailClass(X, ObjProp, ClassProp, Res) :- fluffyTail(X), !, pawSizeClass(X, [пушистыйхвост|ObjProp], [формахвоста|ClassProp], Res).
tailClass(X, ObjProp, ClassProp, Res) :- not(thinTail(X)), not(shortTail(X)), not(fluffyTail(X)), pawSizeClass(X, [обычныйхвост|ObjProp], [формахвоста|ClassProp], Res).

%===Класс по длине лап===
pawSizeClass(классдлинылап, _, ClassProp, Res) :- !, append(ClassProp, [длиналап], Res).
pawSizeClass(объектдлинылап, ObjProp, _, Res) :- !, append(ObjProp, [[короткиелапы, обычныелапы]], Res).

pawSizeClass(X, ObjProp, ClassProp, Res) :- shortPaws(X), !, eyeColorClass(X, [короткиелапы|ObjProp], [длиналап|ClassProp], Res).
pawSizeClass(X, ObjProp, ClassProp, Res) :- not(shortPaws(X)), eyeColorClass(X, [обычныелапы|ObjProp], [длиналап|ClassProp], Res).

%===Класс по цвету глаз===
eyeColorClass(классцветаглаз, _, ClassProp, Res) :- !, append(ClassProp, [цветглаз], Res).
eyeColorClass(объектцветаглаз, ObjProp, _, Res) :- !, append(ObjProp, [[разноцветныеглаза, одноцветныеглаза]], Res).

eyeColorClass(X, ObjProp, ClassProp, Res) :- differentEyes(X), catSizeClass(X, [разноцветныеглаза|ObjProp], [цветглаз|ClassProp], Res).
eyeColorClass(X, ObjProp, ClassProp, Res) :- orangeEyes(X), catSizeClass(X, [оранжевыеглаза|ObjProp], [цветглаз|ClassProp], Res).
eyeColorClass(X, ObjProp, ClassProp, Res) :- blueEyes(X), catSizeClass(X, [голубыеглаза|ObjProp], [цветглаз|ClassProp], Res).
eyeColorClass(X, ObjProp, ClassProp, Res) :- cat(X, Age, _), Age =< 2, catSizeClass(X, [голубыеглаза|ObjProp], [цветглаз|ClassProp], Res).
eyeColorClass(X, ObjProp, ClassProp, Res) :- not(differentEyes(X)), catSizeClass(X, [оранжевыеглаза|ObjProp], [цветглаз|ClassProp], Res).

%===Класс по размеру тела===
catSizeClass(классразмератела, _, ClassProp, Res) :- !, append(ClassProp, [размертела], Res).
catSizeClass(объектразмератела, ObjProp, _, Res) :- !, append(ObjProp, [[крупнаякошка, обычнаякошка]], Res).

catSizeClass(X, ObjProp, ClassProp, Res) :- bigSize(X), !, fatCatClass(X, [крупнаякошка|ObjProp], [размертела|ClassProp], Res).
catSizeClass(X, ObjProp, ClassProp, Res) :- not(bigSize(X)), fatCatClass(X, [обычнаякошка|ObjProp], [размертела|ClassProp], Res).

%===Свойство толстости кошки===
fatCatClass(класстолстостикошки, _, ClassProp, Res) :- !, append(ClassProp, [толстостькошки], Res).
fatCatClass(объекттолстостикошки, ObjProp, _, Res) :- !, append(ObjProp, [[толстощёкая, обычныещёки]], Res).

fatCatClass(X, ObjProp, _, Res) :- cat(X, _, Weight), Weight>=10, append(ObjProp, [толстощёкая], Res).
fatCatClass(X, ObjProp, _, Res) :- cat(X, _, Weight), Weight<10, append(ObjProp, [обычныещёки], Res).

%===Определение значения свойства===
findWoolClass(X, Prop) :- find(X,_,_,Res), member(короткаяшерсть, Res), Prop = короткаяшерсть.
findWoolClass(X, Prop) :- find(X,_,_,Res), member(длиннаяшерсть, Res), Prop = длиннаяшерсть.
findWoolClass(X, Prop) :- find(X,_,_,Res), member(безшерсти, Res), Prop = безшерсти. 

findAllWoolClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), find(X,_,_,Res), member(Prop, Res).

findHomeClass(X, Prop) :- find(X,_,_,Res), member(домашняя, Res), Prop = домашняя.
findHomeClass(X, Prop) :- find(X,_,_,Res), member(дикая, Res), Prop = дикая.

findAllHomeClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классобитания), dif(X, объектобитания), find(X,_,_,Res), member(Prop, Res).

findOriginClass(X, Prop) :- find(X,_,_,Res), member(скандинавия, Res), Prop = скандинавия.
findOriginClass(X, Prop) :- find(X,_,_,Res), member(европа, Res), Prop = европа.
findOriginClass(X, Prop) :- find(X,_,_,Res), member(африка, Res), Prop = африка.

findAllOriginClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, класспроисхождения), dif(X, объектпроисхождения), find(X,_,_,Res), member(Prop, Res).

findPawPadColorClass(X, Prop) :- find(X,_,_,Res), member(розовыеподушечкилап, Res), Prop = розовыеподушечкилап.
findPawPadColorClass(X, Prop) :- find(X,_,_,Res), member(серыеподушечкилап, Res), Prop = серыеподушечкилап.
findPawPadColorClass(X, Prop) :- find(X,_,_,Res), member(чёрныеподушечкилап, Res), Prop = чёрныеподушечкилап.

findAllPawPadColorClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классцветаподушечеклап), dif(X, объектцветаподушечеклап), find(X,_,_,Res), member(Prop, Res).

findEarClass(X, Prop) :- find(X,_,_,Res), member(специальнаяформаушей, Res), Prop = специальнаяформаушей.
findEarClass(X, Prop) :- find(X,_,_,Res), member(вислоухая, Res), Prop = вислоухая.
findEarClass(X, Prop) :- find(X,_,_,Res), member(кисточкинаушах, Res), Prop = кисточкинаушах.
findEarClass(X, Prop) :- find(X,_,_,Res), member(обычныеуши, Res), Prop = обычныеуши.

findAllEarClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классформыушей), dif(X, объектформыушей), find(X,_,_,Res), member(Prop, Res).

findTailClass(X, Prop) :- find(X,_,_,Res), member(тонкийхвост, Res), Prop = тонкийхвост.
findTailClass(X, Prop) :- find(X,_,_,Res), member(пушистыйхвост, Res), Prop = пушистыйхвост.
findTailClass(X, Prop) :- find(X,_,_,Res), member(короткийхвост, Res), Prop = короткийхвост.
findTailClass(X, Prop) :- find(X,_,_,Res), member(обычныйхвост, Res), Prop = обычныйхвост.

findAllTailClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классформыхвоста), dif(X, объектформыхвоста), find(X,_,_,Res), member(Prop, Res).

findPawSizeClass(X, Prop) :- find(X,_,_,Res), member(короткиелапы, Res), Prop = короткиелапы.
findPawSizeClass(X, Prop) :- find(X,_,_,Res), member(обычныелапы, Res), Prop = обычныелапы.

findAllPawSizeClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классдлинылап), dif(X, объектдлинылап), find(X,_,_,Res), member(Prop, Res).

findEyeColorClass(X, Prop) :- find(X,_,_,Res), member(разноцветныеглаза, Res), Prop = разноцветныеглаза.
findEyeColorClass(X, Prop) :- find(X,_,_,Res), member(голубыеглаза, Res), Prop = голубыеглаза.
findEyeColorClass(X, Prop) :- find(X,_,_,Res), member(оранжевыеглаза, Res), Prop = оранжевыеглаза.

findAllEyeColorClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классцветаглаз), dif(X, объектцветаглаз), find(X,_,_,Res), member(Prop, Res).

findCatSizeClass(X, Prop) :- find(X,_,_,Res), member(крупнаякошка, Res), Prop = крупнаякошка.
findCatSizeClass(X, Prop) :- find(X,_,_,Res), member(обычнаякошка, Res), Prop = обычнаякошка.

findAllCatSizeClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, классразмератела), dif(X, объектразмератела), find(X,_,_,Res), member(Prop, Res).

findFatCatClass(X, Prop) :- find(X,_,_,Res), member(толстощёкая, Res), Prop = толстощёкая.
findFatCatClass(X, Prop) :- find(X,_,_,Res), member(обычныещёки, Res), Prop = обычныещёки.

findAllFatCatClass(X, Prop) :- dif(X, класстипшерсти), dif(X, объекттипшерсти), dif(X, класстолстостикошки), dif(X, объекттолстостикошки), find(X,_,_,Res), member(Prop, Res).

%===Поиск различий в свойсвах у двух классов===

differences(Cat1, Cat2, Def1, Def2) :- find(Cat1,_,_,Res1), find(Cat2,_,_,Res2), subtraction(Res1, Res2, Def1), subtraction(Res2, Res1, Def2).

%===Скрещивание пород кошек===
concatCat(шотландская, европейская, CatProps) :- find(шотландская,_,_,Res1), find(европейская,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(пуделькэт,0,0.5)), setupProps(пуделькэт, CatProps).
concatCat(европейская, шотландская, CatProps) :- find(шотландская,_,_,Res1), find(европейская,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(пуделькэт,0,0.5)), setupProps(пуделькэт, CatProps).
concatCat(эльф, сфинкс, CatProps) :- find(эльф,_,_,Res1), find(сфинкс,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(бамбино,0,0.5)), setupProps(бамбино, CatProps), assertz(thinTail(бамбино)).
concatCat(сфинкс, эльф, CatProps) :- find(эльф,_,_,Res1), find(сфинкс,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(бамбино,0,0.5)), setupProps(бамбино, CatProps), assertz(thinTail(бамбино)).
concatCat(персидская, мейнкун, CatProps) :- find(персидская,_,_,Res1), find(мейнкун,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(норвежскийлеснойкот,0,0.5)), setupProps(норвежскийлеснойкот, CatProps), assertz(bigSize(норвежскийлеснойкот)).
concatCat(мейнкун, персидская, CatProps) :- find(персидская,_,_,Res1), find(мейнкун,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(норвежскийлеснойкот,0,0.5)), setupProps(норвежскийлеснойкот, CatProps), assertz(bigSize(норвежскийлеснойкот)).
concatCat(манчкин, шотландская, CatProps) :- find(шотландская,_,_,Res1), find(европейская,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(мэнская,0,0.5)), setupProps(мэнская, CatProps), assertz(specialEar(мэнская)), assertz(shortTail(мэнская)).
concatCat(шотландская, манчкин, CatProps) :- find(шотландская,_,_,Res1), find(европейская,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(мэнская,0,0.5)), setupProps(мэнская, CatProps), assertz(specialEar(мэнская)), assertz(shortTail(мэнская)).
concatCat(Cat1, Cat2, CatProps) :- find(Cat1,_,_,Res1), find(Cat2,_,_,Res2), !, inters(Res1, Res2, CatProps), assertz(cat(домашняя,0,0.5)), setupProps(домашняя, CatProps).

setupProps(_, []) :- !.
setupProps(Cat, [Prop|T]) :- member(Prop, [короткаяшерсть,длиннаяшерсть,безшерсти]), !, setWool(Cat, Prop), setupProps(Cat, T).
setupProps(Cat, [Prop|T]) :- member(Prop, [домашняя,дикая]), !, setHome(Cat, Prop), setupProps(Cat, T).
setupProps(Cat, [Prop|T]) :- member(Prop, [вислоухая,специальнаяформаушей,кисточкинаушах]), !, setEar(Cat, Prop), setupProps(Cat, T).
setupProps(Cat, [Prop|T]) :- member(Prop, [тонкийхвост,пушистыйхвост,короткийхвост]), !, setTail(Cat, Prop), setupProps(Cat, T).
setupProps(Cat, [_|T]) :- !, setupProps(Cat, T).

setWool(Cat, Prop) :- not(dif(Prop, короткаяшерсть)), assertz(shortWool(Cat)).
setWool(Cat, Prop) :- not(dif(Prop, длиннаяшерсть)), assertz(longWool(Cat)).
setWool(Cat, Prop) :- not(dif(Prop, безшерсти)), assertz(withoutWool(Cat)).

setHome(Cat, Prop) :- not(dif(Prop, домашняя)), assertz(home(Cat)).
setHome(Cat, Prop) :- not(dif(Prop, дикая)), assertz(wild(Cat)).

setEar(Cat, Prop) :- not(dif(Prop, вислоухая)), assertz(lopEar(Cat)).
setEar(Cat, Prop) :- not(dif(Prop, специальнаяформаушей)), assertz(specialEar(Cat)).
setEar(Cat, Prop) :- not(dif(Prop, кисточкинаушах)), assertz(brushesEar(Cat)).
setEar(_, Prop) :- not(dif(Prop, обычныеуши)), !.

setTail(Cat, Prop) :- not(dif(Prop, тонкийхвост)), assertz(thinTail(Cat)).
setTail(Cat, Prop) :- not(dif(Prop, пушистыйхвост)), assertz(fluffyTail(Cat)).
setTail(Cat, Prop) :- not(dif(Prop, короткийхвост)), assertz(shortTail(Cat)).
setTail(_, Prop) :- not(dif(Prop, обычныйхвост)), !.

setEyeColor(Cat, Prop) :- not(dif(Prop, оранжевыеглаза)), assertz(orangeEyes(Cat)).
setEyeColor(Cat, Prop) :- not(dif(Prop, голубыеглаза)), assertz(blueEyes(Cat)).
setEyeColor(Cat, Prop) :- not(dif(Prop, разноцветныеглаза)), assertz(differentEyes(Cat)).

setPawPadColor(Cat, Prop) :- not(dif(Prop, чёрныеподушечкилап)), assertz(pawPadColor(Cat, чёрныеподушечкилап)).
setPawPadColor(Cat, Prop) :- not(dif(Prop, серыеподушечкилап)), assertz(pawPadColor(Cat, серыеподушечкилап)).
setPawPadColor(_, Prop) :- not(dif(Prop, розовыеподушечкилап)), !.

deleteAllEar(Cat) :- retract(lopEar(Cat)).
deleteAllEar(Cat) :- retract(brushesEar(Cat)).
deleteAllEar(Cat) :- retract(specialEar(Cat)).
deleteAllEar(_) :- !.

deleteAllTail(Cat) :- retract(thinTail(Cat)).
deleteAllTail(Cat) :- retract(fluffyTail(Cat)).
deleteAllTail(Cat) :- retract(shortTail(Cat)).
deleteAllTail(_) :- !.

deleteEyeColor(Cat) :- retract(differentEyes(Cat)).
deleteEyeColor(Cat) :- retract(orangeEyes(Cat)).
deleteEyeColor(Cat) :- retract(blueEyes(Cat)).
deleteEyeColor(_) :- !.

deletePawPadColor(Cat) :- retract(pawPadColor(Cat, _)).
deletePawPadColor(_) :- !.

%===Меню===
main_menu :-
	nl, write('------------------Меню-------------------------'), nl,
	write('0 - Выход'), nl,
	write('1 - Список операций'), nl,
	write('2 - Информация о программе'), nl,
	write('-----------------------------------------------'), nl,
	read(Item), main_menu_item(Item).

main_menu_item(0):-!.
main_menu_item(1):-
	list_menu, main_menu, !.
main_menu_item(2):-
  	print_info, main_menu, !.
main_menu_item(_Item):-
	write('Неизвестный номер, пожалуйста введите число [0-2]'), nl,
	main_menu.

list_menu:-
	nl, write('------------------Меню-------------------------'), nl,
	write('0 - Назад'), nl,
	write('1 - Найти все свойства определённой породы'), nl,
	write('2 - Проверить свойство у породы'), nl,
	write('3 - Найти всех кошек с определённым свойством'), nl,
	write('4 - Получить новую породу кошек путём скрещивания'), nl,
	write('5 - Проверить какие кошки есть в базе'), nl,
	write('6 - Найти отличия между двумя кошками'), nl,
	write('7 - Ввести новую собственную породу'), nl,
	write('8 - Поменять/добавить свойство кошке'), nl,
	write('-----------------------------------------------'), nl,
	read(Item), list_menu_item(Item).
list_menu_item(0):-!.
list_menu_item(1):-
	write('Введите название породы кошки'), nl, read(Cat), find(Cat,_,_,Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	list_menu.
list_menu_item(2):-
	prop_menu, list_menu, !.
list_menu_item(3):-
	findall_menu, list_menu, !.
list_menu_item(4):-
	write('Введите название породы первой кошки'), nl, read(Cat1),
	write('Введите название породы второй кошки'), nl, read(Cat2),
	concatCat(Cat1, Cat2, Res),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	list_menu.
list_menu_item(5):-
	findall(X, cat(X,_,_), Res),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	list_menu.
list_menu_item(6):-
	write('Введите название породы первой кошки'), nl, read(Cat1),
	write('Введите название породы второй кошки'), nl, read(Cat2),
	differences(Cat1,Cat2,Dif1,Dif2),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write('У первой кошки: '),
	write(Dif1), nl, write('У второй кошки: '), write(Dif2),
	nl, write('-----------------------------------------------'), nl, !,
	list_menu.
list_menu_item(7):-
	write("Введите название породы кошки"), nl, read(Name), write("Введите возраст кошки"),
	nl, read(Age), write("Введите вес кошки"), nl, read(Weight), assertz(cat(Name,Age,Weight)), 
	write("Какой тип шерсти у этой кошки?"), nl, read(Wool), setWool(Name, Wool), write("Эта кошка дикая или домашняя?"), nl, 
	read(Home), setHome(Name, Home), write("Какие уши у этой кошки? Введите <обычныеуши>, если не знаете."), nl, read(Ear), setEar(Name, Ear), write("Какой хвост у данной кошки? Введите <обычныйхвост>, если не знаете."), nl, read(Tail), setTail(Name,Tail),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Name), write(" успешно добавлена в базу данных!"), 
	nl, write('-----------------------------------------------'), nl, !,
	list_menu.
list_menu_item(8):-
	change_menu, list_menu, !.
list_menu_item(_Item):-
	write('Неизвестный номер, пожалуйста введите число [0-8]'), nl,
	list_menu.
  
print_info:-
	write('Prolog Programm By © Korotkov Boris, Group 424'), nl,
	write('=== Онтология кошек ==='), nl.

change_menu:-
	nl, write('------------------Меню-------------------------'), nl,
	write('0 - Назад'), nl,
	write('1 - Добвить/изменить форму ушей'), nl,
	write('2 - Добвить/изменить цвет глаз'), nl,
	write('3 - Добвить/изменить цвет подушечек лап'), nl,
	write('4 - Изменить возраст'), nl,
	write('5 - Изменить вес'), nl,
	write('-----------------------------------------------'), nl,
	read(Item), change_menu_item(Item).
change_menu_item(0):-!.
change_menu_item(1):-
	write('Введите название породы кошки'), nl, read(Cat), deleteAllEar(Cat), 
	write("Введите форму ушей, которую должна иметь кошка"), nl, read(Ear), setEar(Cat, Ear),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write("Форма ушей изменена!"), 
	nl, write('-----------------------------------------------'), nl, !,
	change_menu.
change_menu_item(2):-
	write('Введите название породы кошки'), nl, read(Cat), deleteEyeColor(Cat), 
	write("Введите цвет глаз, который должна иметь кошка"), nl, read(Eye), setEyeColor(Cat, Eye),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write("Цвет глаз изменён!"), 
	nl, write('-----------------------------------------------'), nl, !,
	change_menu.
change_menu_item(3):-
	write('Введите название породы кошки'), nl, read(Cat), deletePawPadColor(Cat), 
	write("Введите цвет подушечек лап, который должна иметь кошка"), nl, read(PawPad), setPawPadColor(Cat,PawPad),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write("Цвет подушечек лап изменён!"), 
	nl, write('-----------------------------------------------'), nl, !,
	change_menu.
change_menu_item(4):-
	write('Введите название породы кошки'), nl, read(Cat), retract(cat(Cat,_,Weight)),
	write("Введите новый возраст кошки"), read(Age), assertz(cat(Cat,Age,Weight)), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write("Возраст изменён!"), 
	nl, write('-----------------------------------------------'), nl, !,
	change_menu.
change_menu_item(5):-
	write('Введите название породы кошки'), nl, read(Cat), retract(cat(Cat,Age,_)),
	write("Введите новый вес кошки"), read(Weight), assertz(cat(Cat,Age,Weight)),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write("Вес изменён!"), 
	nl, write('-----------------------------------------------'), nl, !,
	change_menu.
change_menu_item(_Item):-
	write('Неизвестный номер, пожалуйста введите число [0-5]'), nl,
	change_menu.

prop_menu:-
	nl, write('------------------Меню-------------------------'), nl,
	write('0 - Назад'), nl,
	write('1 - Посмотреть тип шерсти'), nl,
	write('2 - Посмотреть домашняя она или дикая'), nl,
	write('3 - Посмотреть откуда данная порода'), nl,
	write('4 - Посмотреть цвет подушечек лап'), nl,
	write('5 - Посмотреть тип ушей'), nl,
	write('6 - Посмотреть тип хвоста'), nl,
	write('7 - Посмотреть размер лап'), nl,
	write('8 - Посмотреть цвет глаз'), nl,
	write('9 - Посмотреть размер тела'), nl,
	write('10 - Посмотреть тип щёк'), nl,
	write('-----------------------------------------------'), nl,
	read(Item), prop_menu_item(Item).
prop_menu_item(0):-!.
prop_menu_item(1):-
	write('Введите название породы кошки'), nl, read(Cat), findWoolClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(2):-
	write('Введите название породы кошки'), nl, read(Cat), findHomeClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(3):-
	write('Введите название породы кошки'), nl, read(Cat), findOriginClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(4):-
	write('Введите название породы кошки'), nl, read(Cat), findPawPadColorClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(5):-
	write('Введите название породы кошки'), nl, read(Cat), findEarClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(6):-
	write('Введите название породы кошки'), nl, read(Cat), findTailClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(7):-
	write('Введите название породы кошки'), nl, read(Cat), findPawSizeClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(8):-
	write('Введите название породы кошки'), nl, read(Cat), findEyeColorClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(9):-
	write('Введите название породы кошки'), nl, read(Cat), findCatSizeClass(Cat, Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(10):-
	write('Введите название породы кошки'), nl, read(Cat), findFatCatClass(Cat, Res),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	prop_menu.
prop_menu_item(_Item):-
	write('Неизвестный номер, пожалуйста введите число [0-10]'), nl,
	prop_menu.

findall_menu:-
	nl, write('------------------Меню-------------------------'), nl,
	write('0 - Назад'), nl,
	write('1 - По типу шерсти'), nl,
	write('2 - Домашняя она или дикая'), nl,
	write('3 - По месту происхождения'), nl,
	write('4 - По цвету подушечек лап'), nl,
	write('5 - По типу ушей'), nl,
	write('6 - По типу хвоста'), nl,
	write('7 - По размеру лап'), nl,
	write('8 - По цвету глаз'), nl,
	write('9 - По размеру тела'), nl,
	write('10 - По типу щёк'), nl,
	write('-----------------------------------------------'), nl,
	read(Item), findall_menu_item(Item).
findall_menu_item(0):-!.
findall_menu_item(1):-
	write('Введите тип шерсти'), nl, read(Prop), findall(Cat, findAllWoolClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(2):-
	write('Введите домашняя или дикая'), nl, read(Prop), findall(Cat, findAllHomeClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(3):-
	write('Введите место происхождения породы'), nl, read(Prop), findall(Cat, findAllOriginClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(4):-
	write('Введите цвет подушечек лап'), nl, read(Prop), findall(Cat, findAllPawPadColorClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(5):-
	write('Введите тип ушей'), nl, read(Prop), findall(Cat, findAllEarClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(6):-
	write('Введите тип хвоста'), nl, read(Prop), findall(Cat, findAllTailClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(7):-
	write('Введите размер лап'), nl, read(Prop), findall(Cat, findAllPawSizeClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(8):-
	write('Введите цвет глаз'), nl, read(Prop), findall(Cat, findAllEyeColorClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(9):-
	write('Введите размер тела кошки'), nl, read(Prop), findall(Cat, findAllCatSizeClass(Cat, Prop), Res), 
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(10):-
	write('Введите тип щёк кошки'), nl, read(Prop), findall(Cat, findAllFatCatClass(Cat, Prop), Res),
	write('------------------РЕЗУЛЬТАТ--------------------'), nl, write(Res), 
	nl, write('-----------------------------------------------'), nl, !,
	findall_menu.
findall_menu_item(_Item):-
	write('Неизвестный номер, пожалуйста введите число [0-10]'), nl,
	findall_menu.

%===Вспомогательные функции====================================================
member(H,[H|_]).
member(X,[_|Tail]) :- member(X,Tail).

union([],B,B).
union([H|Tail],B,NewTail) :- union(Tail,B,NewTail),member(H,NewTail),!.
union([H|Tail],B,[H|NewTail]) :- union(Tail,B,NewTail).

phh([]):- nl.
phh([H|T]):- write(H), tab(1), phh(T).

inters([],_,[]).
inters([X|M1],M2,[X|M3]) :- member(X,M2),!,inters(M1,M2,M3).
inters([_|M1],M2,M3) :- inters(M1,M2,M3).

subtraction([], _, []):- !.
subtraction([X|M1], M2, M3):- member(X, M2), !, subtraction(M1, M2, M3).
subtraction([X|M1], M2, [X|M3]):- subtraction(M1, M2, M3).

:- set_prolog_flag(double_quotes, codes).
 
exist_in(SearchCodes, InCodes) :-
    append(_, MiddleCodes, InCodes),
    append(SearchCodes, _, MiddleCodes),
    !.

checkNameXinY(X,Y) :- name(X, Res1), name(Y, Res2), exist_in(Res1, Res2).