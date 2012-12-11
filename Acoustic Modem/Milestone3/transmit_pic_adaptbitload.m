    Fs = 16000;
    
    N = 512;
    M = 4;
    Nq = log2(M);
    L_CP = 150;
    SNR = 100;
    BWusage = 70;
    
    Lt = 10;
    Ld = 50;
%---CREATE TRAINBLOCK---%

    bitStream = randint((N/2-1)*Nq,1,[1,0]); 

    trainblock = qam_mod(bitStream, M);
    
%---Estimate channel & select best tones---%
%     estimatechannel;
    estH = [-0.0211441040039063 + 0.00000000000000i;0.00433182281557306 + 0.0101012276859939i;0.00139461165327369 - 0.0236358728161010i;0.00872710838550126 + 0.00841720448138400i;-0.00870891521094159 - 0.00258210506854713i;-0.00161800710180330 - 0.0135009159619493i;0.00210374908051877 - 0.00763466818293080i;-0.0298063016643217 + 0.00569751224764194i;-0.0298766589417241 + 0.0207784197996481i;-0.0119462197551694 + 0.0121867639990017i;-0.000754479566964966 + 0.0140378212360642i;0.0130148925732646 + 0.00900439223391039i;0.00871219231720231 + 0.00162072899887647i;0.0123249373325781 - 0.0326754079240834i;-0.0511916952413865 - 0.0382808766939960i;-0.0583786770940992 + 0.0488983149492747i;-0.0291063789244742 + 0.0734539538142364i;0.0120574354059461 + 0.0706770049286219i;0.0858080151364379 + 0.0248662582685769i;0.0561334168453958 - 0.00684382330984479i;0.0213220954483474 - 0.0274264584123696i;0.0207475516167179 + 0.00914013165397747i;-0.0138313269931917 + 0.0152300049443399i;0.0208926861536086 + 0.0281505207804744i;0.0554316168748688 + 0.0394079214803815i;0.0994042812848252 + 0.0862934260849017i;0.175291536015929 - 0.0133887768181170i;0.198042385280406 - 0.211809335396343i;0.134269911481027 - 0.253574961598324i;-0.0486414902249841 - 0.351582520754610i;-0.259215496233411 - 0.316891711739563i;-0.412572628389271 - 0.0859366705173433i;-0.364806674053359 + 0.0594045569601606i;-0.321497043615265 + 0.207422369509607i;-0.209345029323735 + 0.311201468097525i;-0.0919048243175789 + 0.357248383547114i;0.0458225169350914 + 0.369767145550235i;0.191370721507622 + 0.339133439022719i;0.276252706988623 + 0.266571489967145i;0.362293459446459 + 0.154447373070723i;0.415819828648485 - 0.00109564917379745i;0.361148500069107 - 0.160422955544530i;0.250871894134833 - 0.281109997977059i;0.118253194003763 - 0.316100511211341i;0.0263788021635330 - 0.324602144641561i;-0.0912742054858298 - 0.264358133639689i;-0.111209920856052 - 0.201551835710642i;-0.193131693987360 - 0.147286993414543i;-0.216206177258992 - 0.102489741822712i;-0.214296408957158 - 0.0578398838204593i;-0.203904642622121 + 0.0128805134509968i;-0.234375374348963 + 0.0724931792650555i;-0.154428909204014 + 0.149521114679342i;-0.105610459857121 + 0.179734136276914i;-0.0263738328870806 + 0.186643733600329i;0.0310257919058336 + 0.155900701887259i;0.0234080107512428 + 0.129752240329604i;0.0646339652042860 + 0.115663324509840i;0.0457247340764729 + 0.107364620065357i;0.0813952754026360 + 0.120531043933252i;0.0947666872860744 + 0.0899277385093886i;0.121057046358213 + 0.0511884407823452i;0.153752964835970 + 0.0460836441926427i;0.122869864245846 + 0.00422061491712522i;0.136247591155310 - 0.0443351580636171i;0.124527161568002 - 0.0831617425909737i;0.0923147043966616 - 0.115566354227419i;0.0671483568077822 - 0.128716153866662i;0.0373960638807151 - 0.135222478752324i;0.00316701667954477 - 0.143441621019532i;-0.0319921284185147 - 0.167124378067691i;-0.0724578886383912 - 0.148643023984315i;-0.111661963693061 - 0.0999065794771494i;-0.146184866358059 - 0.0783927620373856i;-0.157502494180887 - 0.0269483037906806i;-0.162891644294980 + 0.00654466055804250i;-0.157324494408011 + 0.0540994305943123i;-0.140632730681417 + 0.0770802424917087i;-0.110115419181662 + 0.111896679839262i;-0.0686812727121996 + 0.163634612530629i;-0.0318415802060984 + 0.160840912619059i;-0.00651287553283595 + 0.171263358816195i;0.0347437055038439 + 0.143981895123423i;0.0891158629127222 + 0.142221041584745i;0.114607124833362 + 0.111230457246634i;0.138836441752107 + 0.0823131797461084i;0.156689840209976 + 0.0286584673968937i;0.144615758563097 + 0.0112528960352253i;0.154650539405908 - 0.0227970125750149i;0.125465228905522 - 0.0762572186659444i;0.125448976516092 - 0.0944252676855107i;0.103931368055207 - 0.118165596861510i;0.0478667106187837 - 0.146151775047723i;0.0298483420441982 - 0.165162963968153i;-0.00210151984115442 - 0.162439879212529i;-0.0522197573269810 - 0.147244889975662i;-0.0789181413143405 - 0.137479590156897i;-0.103040882888490 - 0.109727545661287i;-0.131707659993905 - 0.0882791622233473i;-0.173805973768520 - 0.0554803013849009i;-0.162547965337555 - 0.0164656498563050i;-0.162411342637323 + 0.00990198237483368i;-0.181293210181473 + 0.0706225788629731i;-0.126967597244801 + 0.0756270281713631i;-0.171031541544685 + 0.0974439472223755i;-0.125845002612277 + 0.161427673446540i;-0.0820472674793533 + 0.192505057484625i;-0.0498276766834975 + 0.243661654216468i;0.0429314077409261 + 0.272420318354369i;0.107561873142889 + 0.253581796544502i;0.170790849460737 + 0.244910335750645i;0.256732354406709 + 0.206316416183766i;0.295839246333424 + 0.118509649694332i;0.351667888257682 + 0.0353200175619386i;0.361323300725284 - 0.0413449757978152i;0.338508344473228 - 0.167497391876933i;0.288731650969859 - 0.235955351860060i;0.242961187606476 - 0.322725947049977i;0.169762244233034 - 0.446640576172145i;0.00848203860411261 - 0.478068130085856i;-0.113191345096507 - 0.465206974597956i;-0.291666546450346 - 0.489296631928897i;-0.426199122484301 - 0.344868049163072i;-0.500151870254127 - 0.256280988136140i;-0.629246223484318 - 0.0709352555340663i;-0.558795146259185 + 0.134718227301182i;-0.537783764478055 + 0.250930247919833i;-0.438311426583740 + 0.464155079649658i;-0.298376921415438 + 0.568867275989459i;-0.170760433400386 + 0.679447035353935i;0.0782526715592791 + 0.688443196478668i;0.283232010745901 + 0.708007094218141i;0.526561567955898 + 0.610403326288794i;0.604581549269937 + 0.381943752004483i;0.730241432321201 + 0.229947221515584i;0.811400303870247 - 0.0193035610252670i;0.736965553907146 - 0.290361699481896i;0.660101543435275 - 0.462907026790661i;0.510005818977615 - 0.660654500236983i;0.295654940534990 - 0.771431195547318i;0.104736740089273 - 0.830595234224086i;-0.134644121214609 - 0.903760279535059i;-0.431849020411274 - 0.809262132997964i;-0.644392591591971 - 0.721204878154855i;-0.914235698107639 - 0.471017970414734i;-0.968208439383018 - 0.129260590861371i;-0.925118329611458 + 0.132408355989576i;-0.880514656485640 + 0.419534390207906i;-0.704364594580949 + 0.634110943813323i;-0.503852818238068 + 0.778349511959088i;-0.298528290599234 + 0.951658754391486i;-0.0351783061118133 + 1.02080364734095i;0.301098515356324 + 1.03006160007915i;0.548927029479407 + 0.937920445588029i;0.870680120930698 + 0.752867304288276i;1.07333696310884 + 0.426790330802668i;1.13763836083317 + 0.0910242239315990i;1.14506785947965 - 0.273258631207612i;1.00061908813265 - 0.600236152329656i;0.782052859744544 - 0.836497021174234i;0.525290271593416 - 1.04490936160301i;0.173592347934605 - 1.14830621925984i;-0.175710876890266 - 1.14765708558570i;-0.467740284379835 - 1.12104789158893i;-0.736068263303792 - 0.943975734389956i;-1.04481052770548 - 0.638208136958052i;-1.15080388258486 - 0.323717456104396i;-1.25594462764812 - 0.0658939808041319i;-1.23903463160503 + 0.368605466575101i;-1.12394948220335 + 0.728770330699881i;-0.862171428161457 + 1.13992221849517i;-0.484429205731795 + 1.32931067614250i;-0.0285099510468304 + 1.39392242855717i;0.371681859504746 + 1.30237676180354i;0.756412108472001 + 1.16038703526076i;1.00764545446472 + 0.918979767395111i;1.27937070611186 + 0.506580852586287i;1.41466104338182 + 0.130203628538847i;1.43384923723280 - 0.350395641086291i;1.22036203153460 - 0.797809977235332i;0.872783834234876 - 1.07343845214169i;0.461477088449095 - 1.42644490619733i;-0.00934273022307545 - 1.40226209396818i;-0.422755602450049 - 1.36917067986599i;-0.880860228636225 - 1.06708775253397i;-1.12132571707368 - 0.747771288729500i;-1.29731382500974 - 0.290531286399542i;-1.25285534291308 + 0.152960294123153i;-1.10157421184184 + 0.502734880737942i;-0.795078422021124 + 0.850146334349587i;-0.459985804905753 + 0.967277469330657i;-0.0820142724265288 + 1.00188229470699i;0.207870515959997 + 0.910974562360493i;0.439749203713207 + 0.714882586745055i;0.590917355060591 + 0.553687727455292i;0.689503336496078 + 0.245618779920492i;0.659233014663841 + 0.0229485323023361i;0.621578335404081 - 0.161300526074390i;0.442118291472607 - 0.309828185864266i;0.307772778573634 - 0.358479664135535i;0.168211599231722 - 0.401133901377358i;0.0223139176681415 - 0.365427837216851i;-0.0659804687517352 - 0.324892454407020i;-0.123427787161019 - 0.256422320975195i;-0.167636105289940 - 0.182205428975499i;-0.169999297516515 - 0.121174967562073i;-0.174266361429750 - 0.0626196233079980i;-0.151997617340289 - 0.0261547022664622i;-0.142635530646150 + 0.00510176901661653i;-0.115049316569881 + 0.0232957282684460i;-0.0995929557251948 + 0.0302526238313169i;-0.0865176641831478 + 0.0419308532163365i;-0.0730614607942217 + 0.0395365634927307i;-0.0624777395650691 + 0.0472336277675566i;-0.0532128856067520 + 0.0592301563501980i;-0.0510850673155733 + 0.0700563491633039i;-0.0425726463148992 + 0.0747317472976647i;-0.0297770603949103 + 0.0814288125621187i;-0.0117890512775473 + 0.0914747610823194i;0.00826589991128351 + 0.0944265025248067i;0.0320165412929987 + 0.0917275067566238i;0.0563225646896136 + 0.0856165376972811i;0.0800558896927338 + 0.0642805264377098i;0.0887368424903749 + 0.0471146563572372i;0.103007444006796 + 0.0172890877957073i;0.0971084337052499 - 0.0146006576136210i;0.0880764791775328 - 0.0338190963823836i;0.0727179962885641 - 0.0569678738090591i;0.0527717087056315 - 0.0732093435099560i;0.0309079554291318 - 0.0753375791719474i;0.00848163091415387 - 0.0831967818559145i;-0.0120735776955677 - 0.0771118752284210i;-0.0302834116624775 - 0.0709865135784046i;-0.0470192251146720 - 0.0571400187731393i;-0.0572958437680149 - 0.0411396049322374i;-0.0657403064961687 - 0.0233632188913977i;-0.0612461029121714 - 0.00221772447944285i;-0.0591544905764188 + 0.0144220828356205i;-0.0502765391555238 + 0.0307398572801120i;-0.0368893400840113 + 0.0365717987160811i;-0.0247637953008913 + 0.0428935843486503i;-0.00938007585448444 + 0.0448848911010894i;0.00363655507082453 + 0.0402246816844011i;0.0124335967234529 + 0.0358835126139909i;0.0229081135558048 + 0.0284714615742405i;0.0240096291012613 + 0.0207222228639020i;0.0277233634850684 + 0.0138156202071220i;0.0289626538140396 + 0.00271610460581249i;0.0244447552342327 - 0.00385737505484012i;0.0200045945560288 - 0.0103488561090405i;0.0155653936172407 - 0.0148228287050532i;0.00805630109289597 - 0.0180054688414568i;-0.000646250259696370 - 0.0186802562603086i;-0.00570058322875700 - 0.0158334482007625i;-0.0102481998403999 - 0.0113440093443032i;-0.0136042033329741 - 0.00583746737234056i;0.000305480957031250 + 0.00000000000000i;-0.0136042033329741 + 0.00583746737234056i;-0.0102481998403999 + 0.0113440093443032i;-0.00570058322875700 + 0.0158334482007625i;-0.000646250259696370 + 0.0186802562603086i;0.00805630109289597 + 0.0180054688414568i;0.0155653936172407 + 0.0148228287050532i;0.0200045945560288 + 0.0103488561090405i;0.0244447552342327 + 0.00385737505484012i;0.0289626538140396 - 0.00271610460581249i;0.0277233634850684 - 0.0138156202071220i;0.0240096291012613 - 0.0207222228639020i;0.0229081135558048 - 0.0284714615742405i;0.0124335967234529 - 0.0358835126139909i;0.00363655507082453 - 0.0402246816844011i;-0.00938007585448444 - 0.0448848911010894i;-0.0247637953008913 - 0.0428935843486503i;-0.0368893400840113 - 0.0365717987160811i;-0.0502765391555238 - 0.0307398572801120i;-0.0591544905764188 - 0.0144220828356205i;-0.0612461029121714 + 0.00221772447944285i;-0.0657403064961687 + 0.0233632188913977i;-0.0572958437680149 + 0.0411396049322374i;-0.0470192251146720 + 0.0571400187731393i;-0.0302834116624775 + 0.0709865135784046i;-0.0120735776955677 + 0.0771118752284210i;0.00848163091415387 + 0.0831967818559145i;0.0309079554291318 + 0.0753375791719474i;0.0527717087056315 + 0.0732093435099560i;0.0727179962885641 + 0.0569678738090591i;0.0880764791775328 + 0.0338190963823836i;0.0971084337052499 + 0.0146006576136210i;0.103007444006796 - 0.0172890877957073i;0.0887368424903749 - 0.0471146563572372i;0.0800558896927338 - 0.0642805264377098i;0.0563225646896136 - 0.0856165376972811i;0.0320165412929987 - 0.0917275067566238i;0.00826589991128351 - 0.0944265025248067i;-0.0117890512775473 - 0.0914747610823194i;-0.0297770603949103 - 0.0814288125621187i;-0.0425726463148992 - 0.0747317472976647i;-0.0510850673155733 - 0.0700563491633039i;-0.0532128856067520 - 0.0592301563501980i;-0.0624777395650691 - 0.0472336277675566i;-0.0730614607942217 - 0.0395365634927307i;-0.0865176641831478 - 0.0419308532163365i;-0.0995929557251948 - 0.0302526238313169i;-0.115049316569881 - 0.0232957282684460i;-0.142635530646150 - 0.00510176901661653i;-0.151997617340289 + 0.0261547022664622i;-0.174266361429750 + 0.0626196233079980i;-0.169999297516515 + 0.121174967562073i;-0.167636105289940 + 0.182205428975499i;-0.123427787161019 + 0.256422320975195i;-0.0659804687517352 + 0.324892454407020i;0.0223139176681415 + 0.365427837216851i;0.168211599231722 + 0.401133901377358i;0.307772778573634 + 0.358479664135535i;0.442118291472607 + 0.309828185864266i;0.621578335404081 + 0.161300526074390i;0.659233014663841 - 0.0229485323023361i;0.689503336496078 - 0.245618779920492i;0.590917355060591 - 0.553687727455292i;0.439749203713207 - 0.714882586745055i;0.207870515959997 - 0.910974562360493i;-0.0820142724265288 - 1.00188229470699i;-0.459985804905753 - 0.967277469330657i;-0.795078422021124 - 0.850146334349587i;-1.10157421184184 - 0.502734880737942i;-1.25285534291308 - 0.152960294123153i;-1.29731382500974 + 0.290531286399542i;-1.12132571707368 + 0.747771288729500i;-0.880860228636225 + 1.06708775253397i;-0.422755602450049 + 1.36917067986599i;-0.00934273022307545 + 1.40226209396818i;0.461477088449095 + 1.42644490619733i;0.872783834234876 + 1.07343845214169i;1.22036203153460 + 0.797809977235332i;1.43384923723280 + 0.350395641086291i;1.41466104338182 - 0.130203628538847i;1.27937070611186 - 0.506580852586287i;1.00764545446472 - 0.918979767395111i;0.756412108472001 - 1.16038703526076i;0.371681859504746 - 1.30237676180354i;-0.0285099510468304 - 1.39392242855717i;-0.484429205731795 - 1.32931067614250i;-0.862171428161457 - 1.13992221849517i;-1.12394948220335 - 0.728770330699881i;-1.23903463160503 - 0.368605466575101i;-1.25594462764812 + 0.0658939808041319i;-1.15080388258486 + 0.323717456104396i;-1.04481052770548 + 0.638208136958052i;-0.736068263303792 + 0.943975734389956i;-0.467740284379835 + 1.12104789158893i;-0.175710876890266 + 1.14765708558570i;0.173592347934605 + 1.14830621925984i;0.525290271593416 + 1.04490936160301i;0.782052859744544 + 0.836497021174234i;1.00061908813265 + 0.600236152329656i;1.14506785947965 + 0.273258631207612i;1.13763836083317 - 0.0910242239315990i;1.07333696310884 - 0.426790330802668i;0.870680120930698 - 0.752867304288276i;0.548927029479407 - 0.937920445588029i;0.301098515356324 - 1.03006160007915i;-0.0351783061118133 - 1.02080364734095i;-0.298528290599234 - 0.951658754391486i;-0.503852818238068 - 0.778349511959088i;-0.704364594580949 - 0.634110943813323i;-0.880514656485640 - 0.419534390207906i;-0.925118329611458 - 0.132408355989576i;-0.968208439383018 + 0.129260590861371i;-0.914235698107639 + 0.471017970414734i;-0.644392591591971 + 0.721204878154855i;-0.431849020411274 + 0.809262132997964i;-0.134644121214609 + 0.903760279535059i;0.104736740089273 + 0.830595234224086i;0.295654940534990 + 0.771431195547318i;0.510005818977615 + 0.660654500236983i;0.660101543435275 + 0.462907026790661i;0.736965553907146 + 0.290361699481896i;0.811400303870247 + 0.0193035610252670i;0.730241432321201 - 0.229947221515584i;0.604581549269937 - 0.381943752004483i;0.526561567955898 - 0.610403326288794i;0.283232010745901 - 0.708007094218141i;0.0782526715592791 - 0.688443196478668i;-0.170760433400386 - 0.679447035353935i;-0.298376921415438 - 0.568867275989459i;-0.438311426583740 - 0.464155079649658i;-0.537783764478055 - 0.250930247919833i;-0.558795146259185 - 0.134718227301182i;-0.629246223484318 + 0.0709352555340663i;-0.500151870254127 + 0.256280988136140i;-0.426199122484301 + 0.344868049163072i;-0.291666546450346 + 0.489296631928897i;-0.113191345096507 + 0.465206974597956i;0.00848203860411261 + 0.478068130085856i;0.169762244233034 + 0.446640576172145i;0.242961187606476 + 0.322725947049977i;0.288731650969859 + 0.235955351860060i;0.338508344473228 + 0.167497391876933i;0.361323300725284 + 0.0413449757978152i;0.351667888257682 - 0.0353200175619386i;0.295839246333424 - 0.118509649694332i;0.256732354406709 - 0.206316416183766i;0.170790849460737 - 0.244910335750645i;0.107561873142889 - 0.253581796544502i;0.0429314077409261 - 0.272420318354369i;-0.0498276766834975 - 0.243661654216468i;-0.0820472674793533 - 0.192505057484625i;-0.125845002612277 - 0.161427673446540i;-0.171031541544685 - 0.0974439472223755i;-0.126967597244801 - 0.0756270281713631i;-0.181293210181473 - 0.0706225788629731i;-0.162411342637323 - 0.00990198237483368i;-0.162547965337555 + 0.0164656498563050i;-0.173805973768520 + 0.0554803013849009i;-0.131707659993905 + 0.0882791622233473i;-0.103040882888490 + 0.109727545661287i;-0.0789181413143405 + 0.137479590156897i;-0.0522197573269810 + 0.147244889975662i;-0.00210151984115442 + 0.162439879212529i;0.0298483420441982 + 0.165162963968153i;0.0478667106187837 + 0.146151775047723i;0.103931368055207 + 0.118165596861510i;0.125448976516092 + 0.0944252676855107i;0.125465228905522 + 0.0762572186659444i;0.154650539405908 + 0.0227970125750149i;0.144615758563097 - 0.0112528960352253i;0.156689840209976 - 0.0286584673968937i;0.138836441752107 - 0.0823131797461084i;0.114607124833362 - 0.111230457246634i;0.0891158629127222 - 0.142221041584745i;0.0347437055038439 - 0.143981895123423i;-0.00651287553283595 - 0.171263358816195i;-0.0318415802060984 - 0.160840912619059i;-0.0686812727121996 - 0.163634612530629i;-0.110115419181662 - 0.111896679839262i;-0.140632730681417 - 0.0770802424917087i;-0.157324494408011 - 0.0540994305943123i;-0.162891644294980 - 0.00654466055804250i;-0.157502494180887 + 0.0269483037906806i;-0.146184866358059 + 0.0783927620373856i;-0.111661963693061 + 0.0999065794771494i;-0.0724578886383912 + 0.148643023984315i;-0.0319921284185147 + 0.167124378067691i;0.00316701667954477 + 0.143441621019532i;0.0373960638807151 + 0.135222478752324i;0.0671483568077822 + 0.128716153866662i;0.0923147043966616 + 0.115566354227419i;0.124527161568002 + 0.0831617425909737i;0.136247591155310 + 0.0443351580636171i;0.122869864245846 - 0.00422061491712522i;0.153752964835970 - 0.0460836441926427i;0.121057046358213 - 0.0511884407823452i;0.0947666872860744 - 0.0899277385093886i;0.0813952754026360 - 0.120531043933252i;0.0457247340764729 - 0.107364620065357i;0.0646339652042860 - 0.115663324509840i;0.0234080107512428 - 0.129752240329604i;0.0310257919058336 - 0.155900701887259i;-0.0263738328870806 - 0.186643733600329i;-0.105610459857121 - 0.179734136276914i;-0.154428909204014 - 0.149521114679342i;-0.234375374348963 - 0.0724931792650555i;-0.203904642622121 - 0.0128805134509968i;-0.214296408957158 + 0.0578398838204593i;-0.216206177258992 + 0.102489741822712i;-0.193131693987360 + 0.147286993414543i;-0.111209920856052 + 0.201551835710642i;-0.0912742054858298 + 0.264358133639689i;0.0263788021635330 + 0.324602144641561i;0.118253194003763 + 0.316100511211341i;0.250871894134833 + 0.281109997977059i;0.361148500069107 + 0.160422955544530i;0.415819828648485 + 0.00109564917379745i;0.362293459446459 - 0.154447373070723i;0.276252706988623 - 0.266571489967145i;0.191370721507622 - 0.339133439022719i;0.0458225169350914 - 0.369767145550235i;-0.0919048243175789 - 0.357248383547114i;-0.209345029323735 - 0.311201468097525i;-0.321497043615265 - 0.207422369509607i;-0.364806674053359 - 0.0594045569601606i;-0.412572628389271 + 0.0859366705173433i;-0.259215496233411 + 0.316891711739563i;-0.0486414902249841 + 0.351582520754610i;0.134269911481027 + 0.253574961598324i;0.198042385280406 + 0.211809335396343i;0.175291536015929 + 0.0133887768181170i;0.0994042812848252 - 0.0862934260849017i;0.0554316168748688 - 0.0394079214803815i;0.0208926861536086 - 0.0281505207804744i;-0.0138313269931917 - 0.0152300049443399i;0.0207475516167179 - 0.00914013165397747i;0.0213220954483474 + 0.0274264584123696i;0.0561334168453958 + 0.00684382330984479i;0.0858080151364379 - 0.0248662582685769i;0.0120574354059461 - 0.0706770049286219i;-0.0291063789244742 - 0.0734539538142364i;-0.0583786770940992 - 0.0488983149492747i;-0.0511916952413865 + 0.0382808766939960i;0.0123249373325781 + 0.0326754079240834i;0.00871219231720231 - 0.00162072899887647i;0.0130148925732646 - 0.00900439223391039i;-0.000754479566964966 - 0.0140378212360642i;-0.0119462197551694 - 0.0121867639990017i;-0.0298766589417241 - 0.0207784197996481i;-0.0298063016643217 - 0.00569751224764194i;0.00210374908051877 + 0.00763466818293080i;-0.00161800710180330 + 0.0135009159619493i;-0.00870891521094159 + 0.00258210506854713i;0.00872710838550126 - 0.00841720448138400i;0.00139461165327369 + 0.0236358728161010i;0.00433182281557306 - 0.0101012276859939i;];
        
    Ps = abs(estH).^2;
    %     Pn = [0.00302425599637246;0.000444401518584121;0.000324651917648293;0.00169707639809359;0.00231175559568947;0.000847105041963635;0.00321700082834423;0.0124240261526102;0.0134411586242986;0.00399233743808850;0.00178663733208933;0.00348900504951085;0.00257792379975337;0.00256600898970588;0.00177325205526363;0.00149622958843402;0.00126527389864848;0.00135050563191080;0.00179543980560584;0.00122296904347924;0.00176469884723169;0.00182520961721868;0.00209166422594808;0.00330518139734167;0.00333109868105224;0.00337913213642244;0.00309978649004216;0.00210096890588598;0.00170508632588594;0.00205781091482415;0.00231652158291205;0.00178201550211279;0.00198527450626239;0.00252989722022267;0.00218830289542053;0.00199782745889175;0.00142512105448578;0.00105713316443189;0.00122562794509395;0.000938626017154836;0.00105871010963527;0.00113733501334302;0.00113706738441163;0.00154890377723336;0.00145954930229868;0.00187457540333121;0.00253587876441302;0.00193970235579149;0.00173739513994400;0.00191665627069209;0.00133845551872350;0.000996070939012881;0.000779171601378667;0.000657725614364512;0.000850898232840648;0.000957559207666558;0.00132699707839891;0.00177099564995295;0.00168530607305379;0.00131924489514224;0.000978353288420091;0.000774750293086253;0.000775971588935143;0.000541698988132323;0.000294936083910146;0.000237131624583632;0.000191987050535530;0.000259223765569707;0.000191553359468984;0.000488912804070341;0.000917474828087161;0.00118043577107408;0.00123714678544109;0.000994241778218658;0.00137724322703981;0.00154819194201158;0.00200562458089868;0.00245762539884461;0.00215795787773939;0.00330771565596372;0.00313480575602631;0.00242967490966455;0.00484883717028913;0.00524257221616868;0.00377448345688151;0.00395905256811085;0.00305336338929441;0.00173576864663895;0.00120021708866803;0.000519494792664528;0.000279250378292874;0.000262564821135439;0.000304069721961071;0.000408233265790497;0.000607025225888664;0.000816554208653668;0.000871979586695754;0.00103044134042586;0.00127986745206391;0.00135077513059739;0.000844591560240912;0.000882650696415568;0.00130054024159953;0.000796953631812551;0.000515676789967616;0.000573388646633744;0.000595411534916653;0.000774208985112041;0.000732776735355072;0.000722695647993982;0.000649023030182215;0.000453945132031315;0.000583970695985434;0.000707269007320247;0.000523680290406659;0.000641199186760894;0.000897233987781074;0.000798487329688949;0.000819976784887661;0.00100734201601716;0.000901426636544505;0.000595388141127629;0.00101813601227001;0.00128253662863286;0.00108981070810308;0.00176237024503365;0.00155479264952937;0.00126989716173055;0.00174935066466802;0.00139974806961382;0.00149995532157648;0.00143488808028789;0.00150135064564603;0.00218734151216887;0.00190739050982669;0.00174873677912802;0.00155475820251451;0.00155612547195104;0.00206078829340742;0.00148245338665633;0.000997796505806902;0.00159373540172478;0.00175365924550397;0.00166239926664747;0.00295256825217528;0.00336065500760465;0.00284595399255082;0.00386721097477796;0.00398754186736948;0.00387905736615259;0.00466568196399048;0.00580690560300658;0.00658176899881343;0.00467495582102805;0.00457169164602978;0.00513300099297617;0.00513139410325698;0.00766084990148600;0.00595663707200105;0.00647981714187186;0.00932363297805157;0.00734568881693670;0.00985939840536464;0.00910988667273959;0.00856212413214048;0.0129689872228792;0.00878794374490262;0.00944530096733466;0.0124838040140293;0.00883088534885455;0.00869205190472313;0.0105680425974821;0.0132857806402408;0.0114057377291767;0.0134047376032499;0.0174728305420582;0.0128833905311602;0.0189430700593608;0.0210728806085667;0.0149470237865702;0.0226287058518261;0.0228796624430202;0.0160561720750144;0.0222252357674936;0.0285301077718204;0.0266524297910999;0.0241599857293512;0.0250249613506165;0.0253607425854325;0.0264158023557383;0.0359974692516553;0.0351846813012315;0.0267258799949712;0.0359907136557734;0.0333897591393650;0.0275075246128733;0.0348489324045291;0.0302962584556805;0.0292375395084531;0.0266239213902365;0.0290866292916993;0.0386027778971929;0.0365276869175022;0.0391921398908276;0.0319504410831244;0.0276297496226583;0.0314274221848161;0.0242367650492260;0.0278357469208505;0.0295284971241065;0.0257508091345843;0.0239874000450563;0.0175738031762965;0.0162673818229811;0.0152008921267667;0.0131328952777511;0.0110128385715869;0.0113543995608922;0.0153738201888317;0.0129489423671780;0.0108279744679275;0.0107006354450110;0.00935674468469981;0.0100878703611591;0.00872548197829559;0.00620764906154373;0.00603333894324808;0.00643545583341865;0.00616317719965206;0.00581058901431050;0.00480511577191725;0.00418543720031341;0.00612686396402791;0.00600103374811751;0.00442057954971566;0.00614332868015824;0.00669954190134625;0.00546984227112334;0.00399444940296926;0.00313283509963762;0.00502283028193926;0.00481256306131243;0.00326418369992656;0.00364649615528997;0.00308946652368476;0.00257995522991434;0.00221452882798054;0.00162736045332526;0.00201444834384747;0.00211682291191271;0.00182591702231828;0.00176830191442671;0.00229191754135397;0.00221160671555378;0.00131376692681750;0.00177527202393424;];
    Pn = [8.90662532966176e-09;4.68982442282490e-09;8.85485641753911e-10;1.97024264988660e-10;1.44733152491213e-10;1.44783982269224e-10;7.18842319762061e-11;6.87171836773636e-11;7.87341457984057e-11;7.31923587767723e-11;8.16918789567083e-11;6.25560155412898e-11;4.52551156415390e-11;4.90986241365189e-11;4.30036917342373e-11;4.99741464150323e-11;3.41870444081670e-11;2.62810896567247e-11;2.55338991291267e-11;2.41869775053652e-11;2.74751073290914e-11;2.94470340548650e-11;2.85553522520639e-11;2.69122354422943e-11;2.60814768579703e-11;2.78196224541526e-11;2.94380355878343e-11;3.29122805819065e-11;4.73234393900667e-11;4.46598354630836e-11;4.06210297255080e-11;4.20555293200889e-11;4.02985281550105e-11;4.03244164579543e-11;3.39173354459799e-11;3.50248501885052e-11;4.03259562425925e-11;6.71980259370081e-11;4.40761096087909e-11;3.08832947123271e-11;2.30594186582694e-11;2.05407934573622e-11;1.82961396021842e-11;1.69048106502955e-11;1.99772656442041e-11;1.58587742228177e-11;1.34537289086253e-11;1.66386864390900e-11;1.67323548516844e-11;1.78652989027036e-11;1.98323047482772e-11;2.10366277487549e-11;2.14147126868479e-11;1.69262768331269e-11;1.65855798454434e-11;1.89612987915396e-11;1.59186056646758e-11;1.20975469242696e-11;1.09468783168081e-11;1.09399757381775e-11;1.10205250571011e-11;1.15772404252810e-11;1.02687608041466e-11;1.22318537337766e-11;9.85880196856534e-12;9.08044498231300e-12;9.98328097289385e-12;1.09171339239039e-11;1.05470298168009e-11;7.75206991026532e-12;8.92094473841415e-12;9.20117334886847e-12;8.32587452282718e-12;8.12246079177497e-12;8.82277204347024e-12;8.76622407396643e-12;9.88952269956667e-12;8.35687236435843e-12;9.01420863741540e-12;8.91187689698999e-12;8.75291022556683e-12;1.02130362162183e-11;1.03715443762036e-11;7.21102296002375e-12;6.63941233870344e-12;5.79362384773216e-12;7.06264718359908e-12;6.22739865911054e-12;6.69553412304749e-12;8.35329035920575e-12;7.88270183349175e-12;8.82334288353610e-12;7.74103016465532e-12;5.45354268410209e-12;5.55384655712072e-12;7.57682732836161e-12;8.37252674665395e-12;7.07893116106056e-12;8.34638772262674e-12;6.47813368598695e-12;6.71180757768777e-12;6.10181273677224e-12;6.17699296274316e-12;6.55186420448462e-12;6.33752171123846e-12;5.57707241592161e-12;8.39492413124229e-12;7.72889034457833e-12;5.22143638811960e-12;6.26495415068258e-12;5.65376812106991e-12;7.49422058472752e-12;7.57836117235197e-12;5.38492155099182e-12;5.42123963962394e-12;5.94526891895934e-12;4.26551966556741e-12;5.56704415306875e-12;6.11031892104506e-12;6.70475596249363e-12;6.12492369299660e-12;4.16574786664455e-12;4.23316146699951e-12;4.80922752208910e-12;5.04647932622743e-12;4.85097633391218e-12;4.31180682038832e-12;5.88723773893466e-12;4.70597715490031e-12;4.91325096650427e-12;5.02064989423371e-12;5.40757507874114e-12;5.51392946378703e-12;4.25743294236652e-12;4.65146717647159e-12;5.35822374081280e-12;4.47923023237409e-12;4.45902635649403e-12;4.74102762903515e-12;6.18186702888856e-12;6.50009028954602e-12;6.44690622322973e-12;4.76994102127713e-12;4.34206632342061e-12;4.81404165727579e-12;5.01949352814566e-12;4.68207125108241e-12;4.63542784068927e-12;4.54416262887846e-12;4.11452766810197e-12;4.63250255150188e-12;5.02014928307145e-12;4.42553232937182e-12;3.73650098528916e-12;4.78450633339632e-12;4.71349263970277e-12;4.22029405037481e-12;4.68117106202870e-12;4.86258595523240e-12;5.41553298307386e-12;5.01803619459342e-12;5.26969181546567e-12;5.69633275458721e-12;4.59278614247024e-12;4.09511970069685e-12;3.65092340024774e-12;4.31369817474128e-12;4.25611430543722e-12;4.38895374907521e-12;5.32471694538774e-12;5.91262724094546e-12;6.07179506678319e-12;4.29204063609623e-12;4.71856718908249e-12;3.44283145248288e-12;4.55436781085132e-12;5.10909449386210e-12;4.30081602627266e-12;4.53125071075543e-12;4.03058440376744e-12;4.08940757321660e-12;3.91895362789751e-12;4.36207199123849e-12;4.35125174905707e-12;3.75899917430514e-12;3.81089778023245e-12;3.59605878205732e-12;3.57615600451147e-12;3.52221048256378e-12;3.25964424691663e-12;3.60871736984698e-12;3.19180509582659e-12;2.92296596965431e-12;3.56262000099820e-12;3.81202457262588e-12;3.59021452398168e-12;2.97653121592102e-12;3.06304779725525e-12;2.79887672867006e-12;2.67048164569206e-12;2.97490414378251e-12;2.98220109599919e-12;2.55897491493596e-12;2.42213936850505e-12;2.24393176104668e-12;2.65391104113764e-12;2.99612164464626e-12;3.41587687657091e-12;3.22456858672090e-12;2.57761851618486e-12;1.65165053587741e-12;1.92378009469848e-12;1.92960083388316e-12;1.96692327055247e-12;1.67658477859568e-12;1.96932342694057e-12;1.89660088043936e-12;1.54914037969558e-12;1.45704752124098e-12;1.50024185579866e-12;1.57042362899761e-12;1.43186312280512e-12;1.36089213919285e-12;1.01210976654137e-12;9.54304364068637e-13;1.07341612715357e-12;1.07137148138579e-12;1.12307928434272e-12;9.82448029870746e-13;8.38343889477767e-13;8.52943154251709e-13;9.32639007782469e-13;6.66119216626820e-13;7.12391379251434e-13;6.40036669067975e-13;7.07015069774185e-13;6.35913103993579e-13;5.28770556053560e-13;4.41140684484571e-13;4.12443539617686e-13;3.57401616778062e-13;3.56803946833025e-13;4.01109315149299e-13;3.28345344676784e-13;2.89278631337478e-13;3.00501153046255e-13;2.88956897600870e-13;2.45897059935505e-13;2.16316897941248e-13;2.24006586499007e-13;1.47587359291774e-13;2.16155873182907e-13;2.14259316410805e-13;2.10329867383109e-13;1.18577347777644e-13;1.29029525797528e-13;];
    b = floor(log2(1+Ps(1:N/2)./(10^10*(Pn))));
    goodFreqs = find(b>0);
    b2 = b(goodFreqs);
    
%---CREATE qamStream---%
    % Convert BMP image to bitstream
    [bitStream, imageData, colorMap, imageSize, bitsPerPixel] = imagetobitstream('image.bmp');
    bitsperframe = sum(b2);
    rest = rem(size(bitStream,1),Ld*bitsperframe);
    newBitStream = bitStream;
    if ~(rest == 0)
        newBitStream = [bitStream; zeros((Ld*bitsperframe)-rest,1)];
    end  

    P = length(newBitStream) / bitsperframe;
    
    bitMatrix = reshape(newBitStream,bitsperframe,P);

    modulators = modem.qammod('M', 2, 'InputType', 'Bit');
    for i = 2:15
        modulators = [modulators modem.qammod('M', 2^i, 'InputType', 'Bit')];
    end

    k = 0;
    qamMatrix = zeros(length(b2),P);
    for i = 1 : length(b2)
    %       bits = reshape(bitMatrix(i+k:i+k+b2(i)-1,:),P*b2(i),1);
          qamMatrix(i,:) = modulate(modulators(b2(i)),bitMatrix(k+1:k+b2(i),:));
          k = k + b2(i);
    end

    qamStream = reshape(qamMatrix,length(b2)*P,1);

%---OFDM modulation: alternation---%
Tx = ofdm_mod(qamStream,trainblock,N,Ld,Lt,L_CP,P,goodFreqs);

%---Play signal---%

    %PLAY
    tSync = 1000;
    [simin,nbsecs,fs] = initparams(Tx,Fs,tSync);
    %OUTPUT
    sim('recplay');
    out=simout.signals.values;
    out_aligned = alignIO(out,0.05,tSync);
    Rx = out_aligned(1:(N+L_CP)*(P+(P/Ld)*Lt));
    
%     wxOfdmStream = awgn(Rx,SNR,'measured');
%---OFDM demod---%
    [rxQamStream,channel_est] = ofdm_demod(Rx, N,L_CP,Ld,Lt, Tx,trainblock,P,goodFreqs);
    
%---QAM demod---%
   demodulators = modem.qamdemod('M', 2, 'OutputType', 'Bit');
    for i = 2:15
        demodulators = [demodulators modem.qamdemod('M', 2^i, 'OutputType', 'Bit')];
    end

    k = 0;
    rxQamMatrix = reshape(rxQamStream,length(b2),P);
    rxBitMatrix = zeros(bitsperframe,P);
    for i = 1 : length(b2)
          rxBitMatrix(k+1:k+b2(i),:) = demodulate(demodulators(b2(i)),rxQamMatrix(i,:));
          k = k + b2(i);
    end
    rxBitStream = reshape(rxBitMatrix,bitsperframe*P,1);

%---BER---%
    berTransmission = ber(newBitStream(1:length(rxBitStream)),rxBitStream);

 
%---Image---%
    % Construct image from bitstream
    imageRx = bitstreamtoimage(rxBitStream, imageSize, bitsPerPixel);

    % Plot images
    figure()
    subplot(2,1,1); colormap(colorMap); image(imageData); axis image; title('Original image'); drawnow;
    subplot(2,1,2); colormap(colorMap); image(imageRx); axis image; title(['Received image']); drawnow;