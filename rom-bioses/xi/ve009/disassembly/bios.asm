
combined_bios.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	c6                   	(bad)  
       1:	0a 28                	or     (%bx,%si),%ch
       3:	43                   	inc    %bx
       4:	29 20                	sub    %sp,(%bx,%si)
       6:	41                   	inc    %cx
       7:	43                   	inc    %bx
       8:	54                   	push   %sp
       9:	20 20                	and    %ah,(%bx,%si)
       b:	31 39                	xor    %di,(%bx,%di)
       d:	38 34                	cmp    %dh,(%si)
       f:	20 00                	and    %al,(%bx,%si)
      11:	00 02                	add    %al,(%bp,%si)
      13:	00 02                	add    %al,(%bp,%si)
      15:	00 ff                	add    %bh,%bh
      17:	ff a1 02 10          	jmp    *0x1002(%bx,%di)
      1b:	fd                   	std    
      1c:	a1 02 10             	mov    0x1002,%ax
      1f:	fd                   	std    
      20:	b7 05                	mov    $0x5,%bh
      22:	10 fd                	adc    %bh,%ch
      24:	a1 02 10             	mov    0x1002,%ax
      27:	fd                   	std    
      28:	81 02 10 fd          	addw   $0xfd10,(%bp,%si)
      2c:	a1 02 10             	mov    0x1002,%ax
      2f:	fd                   	std    
      30:	9f                   	lahf   
      31:	09 10                	or     %dx,(%bx,%si)
      33:	fd                   	std    
      34:	a1 02 10             	mov    0x1002,%ax
      37:	fd                   	std    
      38:	09 00                	or     %ax,(%bx,%si)
      3a:	00 40 34             	add    %al,0x34(%bx,%si)
      3d:	12 78 56             	adc    0x56(%bx,%si),%bh
      40:	00 00                	add    %al,(%bx,%si)
      42:	b0 00                	mov    $0x0,%al
      44:	00 3e 80 00          	add    %bh,0x80
      48:	00 3e 01 00          	add    %bh,0x1
      4c:	00 02                	add    %al,(%bp,%si)
      4e:	02 00                	add    (%bx,%si),%al
	...
      58:	a9 45 72             	test   $0x7245,%ax
      5b:	72 6f                	jb     0xcc
      5d:	72 20                	jb     0x7f
      5f:	81 52 41 4d 20       	adcw   $0x204d,0x41(%bp,%si)
      64:	d0 d4                	rcl    %ah
      66:	d0 d4                	rcl    %ah
      68:	aa                   	stos   %al,%es:(%di)
      69:	e3 00                	jcxz   0x6b
      6b:	e2 58                	loop   0xc5
      6d:	03 80 03 4d          	add    0x4d03(%bx,%si),%ax
      71:	03 4e 03             	add    0x3(%bp),%cx
      74:	4c                   	dec    %sp
      75:	03 81 03 40          	add    0x4003(%bx,%di),%ax
      79:	03 5c 03             	add    0x3(%si),%bx
      7c:	5d                   	pop    %bp
      7d:	03 00                	add    (%bx,%si),%ax
      7f:	00 5b 43             	add    %bl,0x43(%bp,%di)
      82:	59                   	pop    %cx
      83:	43                   	inc    %bx
      84:	59                   	pop    %cx
      85:	43                   	inc    %bx
      86:	5a                   	pop    %dx
      87:	43                   	inc    %bx
      88:	59                   	pop    %cx
      89:	43                   	inc    %bx
      8a:	00 00                	add    %al,(%bx,%si)
      8c:	5e                   	pop    %si
      8d:	03 7e 03             	add    0x3(%bp),%di
      90:	5f                   	pop    %di
      91:	03 00                	add    (%bx,%si),%ax
      93:	00 30                	add    %dh,(%bx,%si)
      95:	00 00                	add    %al,(%bx,%si)
      97:	3e 04 00             	ds add $0x0,%al
      9a:	0c 00                	or     $0x0,%al
      9c:	24 00                	and    $0x0,%al
      9e:	ff                   	(bad)  
      9f:	ff 04                	incw   (%si)
      a1:	00 02                	add    %al,(%bp,%si)
      a3:	00 04                	add    %al,(%si)
      a5:	00 06 00 04          	add    %al,0x400
      a9:	00 04                	add    %al,(%si)
      ab:	00 ff                	add    %bh,%bh
      ad:	20 4f 66             	and    %cl,0x66(%bx)
      b0:	66 20 20             	data32 and %ah,(%bx,%si)
      b3:	20 20                	and    %ah,(%bx,%si)
      b5:	20 20                	and    %ah,(%bx,%si)
      b7:	20 20                	and    %ah,(%bx,%si)
      b9:	20 20                	and    %ah,(%bx,%si)
      bb:	4d                   	dec    %bp
      bc:	65 6d                	gs insw (%dx),%es:(%di)
      be:	2b 20                	sub    (%bx,%si),%sp
      c0:	20 20                	and    %ah,(%bx,%si)
      c2:	4d                   	dec    %bp
      c3:	65 6d                	gs insw (%dx),%es:(%di)
      c5:	2d 20 20             	sub    $0x2020,%ax
      c8:	53                   	push   %bx
      c9:	74 6f                	je     0x13a
      cb:	72 65                	jb     0x132
      cd:	20 20                	and    %ah,(%bx,%si)
      cf:	52                   	push   %dx
      d0:	65 63 61 6c          	arpl   %sp,%gs:0x6c(%bx,%di)
      d4:	6c                   	insb   (%dx),%es:(%di)
      d5:	ff 00                	incw   (%bx,%si)
      d7:	3e 10 fd             	ds adc %bh,%ch
      da:	ff                   	(bad)  
      db:	ff                   	(bad)  
      dc:	ff                   	(bad)  
      dd:	ff                   	(bad)  
      de:	ff                   	(bad)  
      df:	ff                   	(bad)  
      e0:	ff                   	(bad)  
      e1:	ff                   	(bad)  
      e2:	ff                   	(bad)  
      e3:	ff                   	(bad)  
      e4:	ff                   	(bad)  
      e5:	ff                   	(bad)  
      e6:	ff                   	(bad)  
      e7:	ff                   	(bad)  
      e8:	ff                   	(bad)  
      e9:	ff                   	(bad)  
      ea:	ff                   	(bad)  
      eb:	ff                   	(bad)  
      ec:	ff                   	(bad)  
      ed:	ff                   	(bad)  
      ee:	ff                   	(bad)  
      ef:	ff                   	(bad)  
      f0:	ff                   	(bad)  
      f1:	ff                   	(bad)  
      f2:	ff                   	(bad)  
      f3:	ff                   	(bad)  
      f4:	ff                   	(bad)  
      f5:	ff                   	(bad)  
      f6:	ff                   	(bad)  
      f7:	ff                   	(bad)  
      f8:	ff                   	(bad)  
      f9:	ff                   	(bad)  
      fa:	ff                   	(bad)  
      fb:	ff                   	(bad)  
      fc:	ff                   	(bad)  
      fd:	ff                   	(bad)  
      fe:	ff                   	(bad)  
      ff:	ff                   	(bad)  
     100:	ff                   	(bad)  
     101:	ff                   	(bad)  
     102:	ff                   	(bad)  
     103:	ff                   	(bad)  
     104:	ff                   	(bad)  
     105:	ff                   	(bad)  
     106:	ff                   	(bad)  
     107:	ff                   	(bad)  
     108:	ff                   	(bad)  
     109:	ff                   	(bad)  
     10a:	ff                   	(bad)  
     10b:	ff                   	(bad)  
     10c:	ff                   	(bad)  
     10d:	ff                   	(bad)  
     10e:	ff                   	(bad)  
     10f:	ff                   	(bad)  
     110:	ff                   	(bad)  
     111:	ff                   	(bad)  
     112:	ff                   	(bad)  
     113:	ff                   	(bad)  
     114:	ff                   	(bad)  
     115:	ff                   	(bad)  
     116:	ff                   	(bad)  
     117:	ff                   	(bad)  
     118:	ff                   	(bad)  
     119:	ff                   	(bad)  
     11a:	ff                   	(bad)  
     11b:	ff                   	(bad)  
     11c:	ff                   	(bad)  
     11d:	ff                   	(bad)  
     11e:	ff                   	(bad)  
     11f:	ff                   	(bad)  
     120:	ff                   	(bad)  
     121:	ff                   	(bad)  
     122:	ff                   	(bad)  
     123:	ff                   	(bad)  
     124:	ff                   	(bad)  
     125:	ff                   	(bad)  
     126:	ff                   	(bad)  
     127:	ff                   	(bad)  
     128:	ff                   	(bad)  
     129:	ff                   	(bad)  
     12a:	ff                   	(bad)  
     12b:	ff                   	(bad)  
     12c:	ff                   	(bad)  
     12d:	ff                   	(bad)  
     12e:	ff                   	(bad)  
     12f:	ff                   	(bad)  
     130:	ff                   	(bad)  
     131:	ff                   	(bad)  
     132:	ff                   	(bad)  
     133:	ff                   	(bad)  
     134:	ff                   	(bad)  
     135:	ff                   	(bad)  
     136:	ff                   	(bad)  
     137:	ff                   	(bad)  
     138:	ff                   	(bad)  
     139:	ff                   	(bad)  
     13a:	ff                   	(bad)  
     13b:	ff                   	(bad)  
     13c:	ff                   	(bad)  
     13d:	ff                   	(bad)  
     13e:	ff                   	(bad)  
     13f:	ff                   	(bad)  
     140:	ff                   	(bad)  
     141:	ff                   	(bad)  
     142:	ff                   	(bad)  
     143:	ff                   	(bad)  
     144:	ff                   	(bad)  
     145:	ff                   	(bad)  
     146:	ff                   	(bad)  
     147:	ff                   	(bad)  
     148:	ff                   	(bad)  
     149:	ff                   	(bad)  
     14a:	ff                   	(bad)  
     14b:	ff                   	(bad)  
     14c:	ff                   	(bad)  
     14d:	ff                   	(bad)  
     14e:	ff                   	(bad)  
     14f:	ff                   	(bad)  
     150:	ff                   	(bad)  
     151:	ff                   	(bad)  
     152:	ff                   	(bad)  
     153:	ff                   	(bad)  
     154:	ff                   	(bad)  
     155:	ff                   	(bad)  
     156:	ff                   	(bad)  
     157:	ff                   	(bad)  
     158:	ff                   	(bad)  
     159:	ff                   	(bad)  
     15a:	ff                   	(bad)  
     15b:	ff                   	(bad)  
     15c:	ff                   	(bad)  
     15d:	ff                   	(bad)  
     15e:	ff                   	(bad)  
     15f:	ff                   	(bad)  
     160:	ff                   	(bad)  
     161:	ff                   	(bad)  
     162:	ff                   	(bad)  
     163:	ff                   	(bad)  
     164:	ff                   	(bad)  
     165:	ff                   	(bad)  
     166:	ff                   	(bad)  
     167:	ff                   	(bad)  
     168:	ff                   	(bad)  
     169:	ff                   	(bad)  
     16a:	ff                   	(bad)  
     16b:	ff                   	(bad)  
     16c:	ff                   	(bad)  
     16d:	ff                   	(bad)  
     16e:	ff                   	(bad)  
     16f:	ff                   	(bad)  
     170:	ff                   	(bad)  
     171:	ff                   	(bad)  
     172:	ff                   	(bad)  
     173:	ff                   	(bad)  
     174:	ff                   	(bad)  
     175:	ff                   	(bad)  
     176:	ff                   	(bad)  
     177:	ff                   	(bad)  
     178:	ff                   	(bad)  
     179:	ff                   	(bad)  
     17a:	ff                   	(bad)  
     17b:	ff                   	(bad)  
     17c:	ff                   	(bad)  
     17d:	ff                   	(bad)  
     17e:	ff                   	(bad)  
     17f:	ff                   	(bad)  
     180:	ff                   	(bad)  
     181:	ff                   	(bad)  
     182:	ff                   	(bad)  
     183:	ff                   	(bad)  
     184:	ff                   	(bad)  
     185:	ff                   	(bad)  
     186:	ff                   	(bad)  
     187:	ff                   	(bad)  
     188:	ff                   	(bad)  
     189:	ff                   	(bad)  
     18a:	ff                   	(bad)  
     18b:	ff                   	(bad)  
     18c:	ff                   	(bad)  
     18d:	ff                   	(bad)  
     18e:	ff                   	(bad)  
     18f:	ff                   	(bad)  
     190:	ff                   	(bad)  
     191:	ff                   	(bad)  
     192:	ff                   	(bad)  
     193:	ff                   	(bad)  
     194:	ff                   	(bad)  
     195:	ff                   	(bad)  
     196:	ff                   	(bad)  
     197:	ff                   	(bad)  
     198:	ff                   	(bad)  
     199:	ff                   	(bad)  
     19a:	ff                   	(bad)  
     19b:	ff                   	(bad)  
     19c:	ff                   	(bad)  
     19d:	ff                   	(bad)  
     19e:	ff                   	(bad)  
     19f:	ff                   	(bad)  
     1a0:	ff                   	(bad)  
     1a1:	ff                   	(bad)  
     1a2:	ff                   	(bad)  
     1a3:	ff                   	(bad)  
     1a4:	ff                   	(bad)  
     1a5:	ff                   	(bad)  
     1a6:	ff                   	(bad)  
     1a7:	ff                   	(bad)  
     1a8:	ff                   	(bad)  
     1a9:	ff                   	(bad)  
     1aa:	ff                   	(bad)  
     1ab:	ff                   	(bad)  
     1ac:	ff                   	(bad)  
     1ad:	ff                   	(bad)  
     1ae:	ff                   	(bad)  
     1af:	ff                   	(bad)  
     1b0:	ff                   	(bad)  
     1b1:	ff                   	(bad)  
     1b2:	ff                   	(bad)  
     1b3:	ff                   	(bad)  
     1b4:	ff                   	(bad)  
     1b5:	ff                   	(bad)  
     1b6:	ff                   	(bad)  
     1b7:	ff                   	(bad)  
     1b8:	ff                   	(bad)  
     1b9:	ff                   	(bad)  
     1ba:	ff                   	(bad)  
     1bb:	ff                   	(bad)  
     1bc:	ff                   	(bad)  
     1bd:	ff                   	(bad)  
     1be:	ff                   	(bad)  
     1bf:	ff                   	(bad)  
     1c0:	ff                   	(bad)  
     1c1:	ff                   	(bad)  
     1c2:	ff                   	(bad)  
     1c3:	ff                   	(bad)  
     1c4:	ff                   	(bad)  
     1c5:	ff                   	(bad)  
     1c6:	ff                   	(bad)  
     1c7:	ff                   	(bad)  
     1c8:	ff                   	(bad)  
     1c9:	ff                   	(bad)  
     1ca:	ff                   	(bad)  
     1cb:	ff                   	(bad)  
     1cc:	ff                   	(bad)  
     1cd:	ff                   	(bad)  
     1ce:	ff                   	(bad)  
     1cf:	ff                   	(bad)  
     1d0:	ff                   	(bad)  
     1d1:	ff                   	(bad)  
     1d2:	ff                   	(bad)  
     1d3:	ff                   	(bad)  
     1d4:	ff                   	(bad)  
     1d5:	ff                   	(bad)  
     1d6:	ff                   	(bad)  
     1d7:	ff                   	(bad)  
     1d8:	ff                   	(bad)  
     1d9:	ff                   	(bad)  
     1da:	ff                   	(bad)  
     1db:	ff                   	(bad)  
     1dc:	ff                   	(bad)  
     1dd:	ff                   	(bad)  
     1de:	ff                   	(bad)  
     1df:	ff                   	(bad)  
     1e0:	ff                   	(bad)  
     1e1:	ff                   	(bad)  
     1e2:	ff                   	(bad)  
     1e3:	ff                   	(bad)  
     1e4:	ff                   	(bad)  
     1e5:	ff                   	(bad)  
     1e6:	ff                   	(bad)  
     1e7:	ff                   	(bad)  
     1e8:	ff                   	(bad)  
     1e9:	ff                   	(bad)  
     1ea:	ff                   	(bad)  
     1eb:	ff                   	(bad)  
     1ec:	ff                   	(bad)  
     1ed:	ff                   	(bad)  
     1ee:	ff                   	(bad)  
     1ef:	ff                   	(bad)  
     1f0:	ff                   	(bad)  
     1f1:	ff                   	(bad)  
     1f2:	ff                   	(bad)  
     1f3:	ff                   	(bad)  
     1f4:	ff                   	(bad)  
     1f5:	ff                   	(bad)  
     1f6:	ff                   	(bad)  
     1f7:	ff                   	(bad)  
     1f8:	ff                   	(bad)  
     1f9:	ff                   	(bad)  
     1fa:	ff                   	(bad)  
     1fb:	ff                   	(bad)  
     1fc:	ff                   	(bad)  
     1fd:	ff                   	(bad)  
     1fe:	ff                   	(bad)  
     1ff:	ff                   	(bad)  
     200:	ff                   	(bad)  
     201:	ff                   	(bad)  
     202:	ff                   	(bad)  
     203:	ff                   	(bad)  
     204:	ff                   	(bad)  
     205:	ff                   	(bad)  
     206:	ff                   	(bad)  
     207:	ff                   	(bad)  
     208:	ff                   	(bad)  
     209:	ff                   	(bad)  
     20a:	ff                   	(bad)  
     20b:	ff                   	(bad)  
     20c:	ff                   	(bad)  
     20d:	ff                   	(bad)  
     20e:	ff                   	(bad)  
     20f:	ff                   	(bad)  
     210:	ff                   	(bad)  
     211:	ff                   	(bad)  
     212:	ff                   	(bad)  
     213:	ff                   	(bad)  
     214:	ff                   	(bad)  
     215:	ff                   	(bad)  
     216:	ff                   	(bad)  
     217:	ff                   	(bad)  
     218:	ff                   	(bad)  
     219:	ff                   	(bad)  
     21a:	ff                   	(bad)  
     21b:	ff                   	(bad)  
     21c:	ff                   	(bad)  
     21d:	ff                   	(bad)  
     21e:	ff                   	(bad)  
     21f:	ff                   	(bad)  
     220:	ff                   	(bad)  
     221:	ff                   	(bad)  
     222:	ff                   	(bad)  
     223:	ff                   	(bad)  
     224:	ff                   	(bad)  
     225:	ff                   	(bad)  
     226:	ff                   	(bad)  
     227:	ff                   	(bad)  
     228:	ff                   	(bad)  
     229:	ff                   	(bad)  
     22a:	ff                   	(bad)  
     22b:	ff                   	(bad)  
     22c:	ff                   	(bad)  
     22d:	ff                   	(bad)  
     22e:	ff                   	(bad)  
     22f:	ff                   	(bad)  
     230:	ff                   	(bad)  
     231:	ff                   	(bad)  
     232:	ff                   	(bad)  
     233:	ff                   	(bad)  
     234:	ff                   	(bad)  
     235:	ff                   	(bad)  
     236:	ff                   	(bad)  
     237:	ff                   	(bad)  
     238:	ff                   	(bad)  
     239:	ff                   	(bad)  
     23a:	ff                   	(bad)  
     23b:	ff                   	(bad)  
     23c:	ff                   	(bad)  
     23d:	ff                   	(bad)  
     23e:	ff                   	(bad)  
     23f:	ff                   	(bad)  
     240:	ff                   	(bad)  
     241:	ff                   	(bad)  
     242:	ff                   	(bad)  
     243:	ff                   	(bad)  
     244:	ff                   	(bad)  
     245:	ff                   	(bad)  
     246:	ff                   	(bad)  
     247:	ff                   	(bad)  
     248:	ff                   	(bad)  
     249:	ff                   	(bad)  
     24a:	ff                   	(bad)  
     24b:	ff                   	(bad)  
     24c:	ff                   	(bad)  
     24d:	ff                   	(bad)  
     24e:	ff                   	(bad)  
     24f:	ff                   	(bad)  
     250:	ff                   	(bad)  
     251:	ff                   	(bad)  
     252:	ff                   	(bad)  
     253:	ff                   	(bad)  
     254:	ff                   	(bad)  
     255:	ff                   	(bad)  
     256:	ff                   	(bad)  
     257:	ff                   	(bad)  
     258:	ff                   	(bad)  
     259:	ff                   	(bad)  
     25a:	ff                   	(bad)  
     25b:	ff                   	(bad)  
     25c:	ff                   	(bad)  
     25d:	ff                   	(bad)  
     25e:	ff                   	(bad)  
     25f:	ff                   	(bad)  
     260:	ff                   	(bad)  
     261:	ff                   	(bad)  
     262:	ff                   	(bad)  
     263:	ff                   	(bad)  
     264:	ff                   	(bad)  
     265:	ff                   	(bad)  
     266:	ff                   	(bad)  
     267:	ff                   	(bad)  
     268:	ff                   	(bad)  
     269:	ff                   	(bad)  
     26a:	ff                   	(bad)  
     26b:	ff                   	(bad)  
     26c:	ff                   	(bad)  
     26d:	ff                   	(bad)  
     26e:	ff                   	(bad)  
     26f:	ff                   	(bad)  
     270:	ff                   	(bad)  
     271:	ff                   	(bad)  
     272:	ff                   	(bad)  
     273:	ff                   	(bad)  
     274:	ff                   	(bad)  
     275:	ff                   	(bad)  
     276:	ff                   	(bad)  
     277:	ff                   	(bad)  
     278:	ff                   	(bad)  
     279:	ff                   	(bad)  
     27a:	ff                   	(bad)  
     27b:	ff                   	(bad)  
     27c:	ff                   	(bad)  
     27d:	ff                   	(bad)  
     27e:	ff                   	(bad)  
     27f:	ff                   	(bad)  
     280:	ff                   	(bad)  
     281:	ff                   	(bad)  
     282:	ff                   	(bad)  
     283:	ff                   	(bad)  
     284:	ff                   	(bad)  
     285:	ff                   	(bad)  
     286:	ff                   	(bad)  
     287:	ff                   	(bad)  
     288:	ff                   	(bad)  
     289:	ff                   	(bad)  
     28a:	ff                   	(bad)  
     28b:	ff                   	(bad)  
     28c:	ff                   	(bad)  
     28d:	ff                   	(bad)  
     28e:	ff                   	(bad)  
     28f:	ff                   	(bad)  
     290:	ff                   	(bad)  
     291:	ff                   	(bad)  
     292:	ff                   	(bad)  
     293:	ff                   	(bad)  
     294:	ff                   	(bad)  
     295:	ff                   	(bad)  
     296:	ff                   	(bad)  
     297:	ff                   	(bad)  
     298:	ff                   	(bad)  
     299:	ff                   	(bad)  
     29a:	ff                   	(bad)  
     29b:	ff                   	(bad)  
     29c:	ff                   	(bad)  
     29d:	ff                   	(bad)  
     29e:	ff                   	(bad)  
     29f:	ff                   	(bad)  
     2a0:	ff                   	(bad)  
     2a1:	ff                   	(bad)  
     2a2:	ff                   	(bad)  
     2a3:	ff                   	(bad)  
     2a4:	ff                   	(bad)  
     2a5:	ff                   	(bad)  
     2a6:	ff                   	(bad)  
     2a7:	ff                   	(bad)  
     2a8:	ff                   	(bad)  
     2a9:	ff                   	(bad)  
     2aa:	ff                   	(bad)  
     2ab:	ff                   	(bad)  
     2ac:	ff                   	(bad)  
     2ad:	ff                   	(bad)  
     2ae:	ff                   	(bad)  
     2af:	ff                   	(bad)  
     2b0:	ff                   	(bad)  
     2b1:	ff                   	(bad)  
     2b2:	ff                   	(bad)  
     2b3:	ff                   	(bad)  
     2b4:	ff                   	(bad)  
     2b5:	ff                   	(bad)  
     2b6:	ff                   	(bad)  
     2b7:	ff                   	(bad)  
     2b8:	ff                   	(bad)  
     2b9:	ff                   	(bad)  
     2ba:	ff                   	(bad)  
     2bb:	ff                   	(bad)  
     2bc:	ff                   	(bad)  
     2bd:	ff                   	(bad)  
     2be:	ff                   	(bad)  
     2bf:	ff                   	(bad)  
     2c0:	ff                   	(bad)  
     2c1:	ff                   	(bad)  
     2c2:	ff                   	(bad)  
     2c3:	ff                   	(bad)  
     2c4:	ff                   	(bad)  
     2c5:	ff                   	(bad)  
     2c6:	ff                   	(bad)  
     2c7:	ff                   	(bad)  
     2c8:	ff                   	(bad)  
     2c9:	ff                   	(bad)  
     2ca:	ff                   	(bad)  
     2cb:	ff                   	(bad)  
     2cc:	ff                   	(bad)  
     2cd:	ff                   	(bad)  
     2ce:	ff                   	(bad)  
     2cf:	ff                   	(bad)  
     2d0:	ff                   	(bad)  
     2d1:	ff                   	(bad)  
     2d2:	ff                   	(bad)  
     2d3:	ff                   	(bad)  
     2d4:	ff                   	(bad)  
     2d5:	ff                   	(bad)  
     2d6:	ff                   	(bad)  
     2d7:	ff                   	(bad)  
     2d8:	ff                   	(bad)  
     2d9:	ff                   	(bad)  
     2da:	ff                   	(bad)  
     2db:	ff                   	(bad)  
     2dc:	ff                   	(bad)  
     2dd:	ff                   	(bad)  
     2de:	ff                   	(bad)  
     2df:	ff                   	(bad)  
     2e0:	ff                   	(bad)  
     2e1:	ff                   	(bad)  
     2e2:	ff                   	(bad)  
     2e3:	ff                   	(bad)  
     2e4:	ff                   	(bad)  
     2e5:	ff                   	(bad)  
     2e6:	ff                   	(bad)  
     2e7:	ff                   	(bad)  
     2e8:	ff                   	(bad)  
     2e9:	ff                   	(bad)  
     2ea:	ff                   	(bad)  
     2eb:	ff                   	(bad)  
     2ec:	ff                   	(bad)  
     2ed:	ff                   	(bad)  
     2ee:	ff                   	(bad)  
     2ef:	ff                   	(bad)  
     2f0:	ff                   	(bad)  
     2f1:	ff                   	(bad)  
     2f2:	ff                   	(bad)  
     2f3:	ff                   	(bad)  
     2f4:	ff                   	(bad)  
     2f5:	ff                   	(bad)  
     2f6:	ff                   	(bad)  
     2f7:	ff                   	(bad)  
     2f8:	ff                   	(bad)  
     2f9:	ff                   	(bad)  
     2fa:	ff                   	(bad)  
     2fb:	ff                   	(bad)  
     2fc:	ff                   	(bad)  
     2fd:	ff                   	(bad)  
     2fe:	ff                   	(bad)  
     2ff:	ff                   	(bad)  
     300:	ff                   	(bad)  
     301:	ff                   	(bad)  
     302:	ff                   	(bad)  
     303:	ff                   	(bad)  
     304:	ff                   	(bad)  
     305:	ff                   	(bad)  
     306:	ff                   	(bad)  
     307:	ff                   	(bad)  
     308:	ff                   	(bad)  
     309:	ff                   	(bad)  
     30a:	ff                   	(bad)  
     30b:	ff                   	(bad)  
     30c:	ff                   	(bad)  
     30d:	ff                   	(bad)  
     30e:	ff                   	(bad)  
     30f:	ff                   	(bad)  
     310:	ff                   	(bad)  
     311:	ff                   	(bad)  
     312:	ff                   	(bad)  
     313:	ff                   	(bad)  
     314:	ff                   	(bad)  
     315:	ff                   	(bad)  
     316:	ff                   	(bad)  
     317:	ff                   	(bad)  
     318:	ff                   	(bad)  
     319:	ff                   	(bad)  
     31a:	ff                   	(bad)  
     31b:	ff                   	(bad)  
     31c:	ff                   	(bad)  
     31d:	ff                   	(bad)  
     31e:	ff                   	(bad)  
     31f:	ff                   	(bad)  
     320:	ff                   	(bad)  
     321:	ff                   	(bad)  
     322:	ff                   	(bad)  
     323:	ff                   	(bad)  
     324:	ff                   	(bad)  
     325:	ff                   	(bad)  
     326:	ff                   	(bad)  
     327:	ff                   	(bad)  
     328:	ff                   	(bad)  
     329:	ff                   	(bad)  
     32a:	ff                   	(bad)  
     32b:	ff                   	(bad)  
     32c:	ff                   	(bad)  
     32d:	ff                   	(bad)  
     32e:	ff                   	(bad)  
     32f:	ff                   	(bad)  
     330:	ff                   	(bad)  
     331:	ff                   	(bad)  
     332:	ff                   	(bad)  
     333:	ff                   	(bad)  
     334:	ff                   	(bad)  
     335:	ff                   	(bad)  
     336:	ff                   	(bad)  
     337:	ff                   	(bad)  
     338:	ff                   	(bad)  
     339:	ff                   	(bad)  
     33a:	ff                   	(bad)  
     33b:	ff                   	(bad)  
     33c:	ff                   	(bad)  
     33d:	ff                   	(bad)  
     33e:	ff                   	(bad)  
     33f:	ff                   	(bad)  
     340:	ff                   	(bad)  
     341:	ff                   	(bad)  
     342:	ff                   	(bad)  
     343:	ff                   	(bad)  
     344:	ff                   	(bad)  
     345:	ff                   	(bad)  
     346:	ff                   	(bad)  
     347:	ff                   	(bad)  
     348:	ff                   	(bad)  
     349:	ff                   	(bad)  
     34a:	ff                   	(bad)  
     34b:	ff                   	(bad)  
     34c:	ff                   	(bad)  
     34d:	ff                   	(bad)  
     34e:	ff                   	(bad)  
     34f:	ff                   	(bad)  
     350:	ff                   	(bad)  
     351:	ff                   	(bad)  
     352:	ff                   	(bad)  
     353:	ff                   	(bad)  
     354:	ff                   	(bad)  
     355:	ff                   	(bad)  
     356:	ff                   	(bad)  
     357:	ff                   	(bad)  
     358:	ff                   	(bad)  
     359:	ff                   	(bad)  
     35a:	ff                   	(bad)  
     35b:	ff                   	(bad)  
     35c:	ff                   	(bad)  
     35d:	ff                   	(bad)  
     35e:	ff                   	(bad)  
     35f:	ff                   	(bad)  
     360:	ff                   	(bad)  
     361:	ff                   	(bad)  
     362:	ff                   	(bad)  
     363:	ff                   	(bad)  
     364:	ff                   	(bad)  
     365:	ff                   	(bad)  
     366:	ff                   	(bad)  
     367:	ff                   	(bad)  
     368:	ff                   	(bad)  
     369:	ff                   	(bad)  
     36a:	ff                   	(bad)  
     36b:	ff                   	(bad)  
     36c:	ff                   	(bad)  
     36d:	ff                   	(bad)  
     36e:	ff                   	(bad)  
     36f:	ff                   	(bad)  
     370:	ff                   	(bad)  
     371:	ff                   	(bad)  
     372:	ff                   	(bad)  
     373:	ff                   	(bad)  
     374:	ff                   	(bad)  
     375:	ff                   	(bad)  
     376:	ff                   	(bad)  
     377:	ff                   	(bad)  
     378:	ff                   	(bad)  
     379:	ff                   	(bad)  
     37a:	ff                   	(bad)  
     37b:	ff                   	(bad)  
     37c:	ff                   	(bad)  
     37d:	ff                   	(bad)  
     37e:	ff                   	(bad)  
     37f:	ff                   	(bad)  
     380:	ff                   	(bad)  
     381:	ff                   	(bad)  
     382:	ff                   	(bad)  
     383:	ff                   	(bad)  
     384:	ff                   	(bad)  
     385:	ff                   	(bad)  
     386:	ff                   	(bad)  
     387:	ff                   	(bad)  
     388:	ff                   	(bad)  
     389:	ff                   	(bad)  
     38a:	ff                   	(bad)  
     38b:	ff                   	(bad)  
     38c:	ff                   	(bad)  
     38d:	ff                   	(bad)  
     38e:	ff                   	(bad)  
     38f:	ff                   	(bad)  
     390:	ff                   	(bad)  
     391:	ff                   	(bad)  
     392:	ff                   	(bad)  
     393:	ff                   	(bad)  
     394:	ff                   	(bad)  
     395:	ff                   	(bad)  
     396:	ff                   	(bad)  
     397:	ff                   	(bad)  
     398:	ff                   	(bad)  
     399:	ff                   	(bad)  
     39a:	ff                   	(bad)  
     39b:	ff                   	(bad)  
     39c:	ff                   	(bad)  
     39d:	ff                   	(bad)  
     39e:	ff                   	(bad)  
     39f:	ff                   	(bad)  
     3a0:	ff                   	(bad)  
     3a1:	ff                   	(bad)  
     3a2:	ff                   	(bad)  
     3a3:	ff                   	(bad)  
     3a4:	ff                   	(bad)  
     3a5:	ff                   	(bad)  
     3a6:	ff                   	(bad)  
     3a7:	ff                   	(bad)  
     3a8:	ff                   	(bad)  
     3a9:	ff                   	(bad)  
     3aa:	ff                   	(bad)  
     3ab:	ff                   	(bad)  
     3ac:	ff                   	(bad)  
     3ad:	ff                   	(bad)  
     3ae:	ff                   	(bad)  
     3af:	ff                   	(bad)  
     3b0:	ff                   	(bad)  
     3b1:	ff                   	(bad)  
     3b2:	ff                   	(bad)  
     3b3:	ff                   	(bad)  
     3b4:	ff                   	(bad)  
     3b5:	ff                   	(bad)  
     3b6:	ff                   	(bad)  
     3b7:	ff                   	(bad)  
     3b8:	ff                   	(bad)  
     3b9:	ff                   	(bad)  
     3ba:	ff                   	(bad)  
     3bb:	ff                   	(bad)  
     3bc:	ff                   	(bad)  
     3bd:	ff                   	(bad)  
     3be:	ff                   	(bad)  
     3bf:	ff                   	(bad)  
     3c0:	ff                   	(bad)  
     3c1:	ff                   	(bad)  
     3c2:	ff                   	(bad)  
     3c3:	ff                   	(bad)  
     3c4:	ff                   	(bad)  
     3c5:	ff                   	(bad)  
     3c6:	ff                   	(bad)  
     3c7:	ff                   	(bad)  
     3c8:	ff                   	(bad)  
     3c9:	ff                   	(bad)  
     3ca:	ff                   	(bad)  
     3cb:	ff                   	(bad)  
     3cc:	ff                   	(bad)  
     3cd:	ff                   	(bad)  
     3ce:	ff                   	(bad)  
     3cf:	ff                   	(bad)  
     3d0:	ff                   	(bad)  
     3d1:	ff                   	(bad)  
     3d2:	ff                   	(bad)  
     3d3:	ff                   	(bad)  
     3d4:	ff                   	(bad)  
     3d5:	ff                   	(bad)  
     3d6:	ff                   	(bad)  
     3d7:	ff                   	(bad)  
     3d8:	ff                   	(bad)  
     3d9:	ff                   	(bad)  
     3da:	ff                   	(bad)  
     3db:	ff                   	(bad)  
     3dc:	ff                   	(bad)  
     3dd:	ff                   	(bad)  
     3de:	ff                   	(bad)  
     3df:	ff                   	(bad)  
     3e0:	ff                   	(bad)  
     3e1:	ff                   	(bad)  
     3e2:	ff                   	(bad)  
     3e3:	ff                   	(bad)  
     3e4:	ff                   	(bad)  
     3e5:	ff                   	(bad)  
     3e6:	ff                   	(bad)  
     3e7:	ff                   	(bad)  
     3e8:	ff                   	(bad)  
     3e9:	ff                   	(bad)  
     3ea:	ff                   	(bad)  
     3eb:	ff                   	(bad)  
     3ec:	ff                   	(bad)  
     3ed:	ff                   	(bad)  
     3ee:	ff                   	(bad)  
     3ef:	ff                   	(bad)  
     3f0:	ff                   	(bad)  
     3f1:	ff                   	(bad)  
     3f2:	ff                   	(bad)  
     3f3:	ff                   	(bad)  
     3f4:	ff                   	(bad)  
     3f5:	ff                   	(bad)  
     3f6:	ff                   	(bad)  
     3f7:	ff                   	(bad)  
     3f8:	ff                   	(bad)  
     3f9:	ff                   	(bad)  
     3fa:	ff                   	(bad)  
     3fb:	ff                   	(bad)  
     3fc:	ff                   	(bad)  
     3fd:	ff                   	(bad)  
     3fe:	ff                   	(bad)  
     3ff:	ff                   	(bad)  
     400:	ff                   	(bad)  
     401:	ff                   	(bad)  
     402:	ff                   	(bad)  
     403:	ff                   	(bad)  
     404:	ff                   	(bad)  
     405:	ff                   	(bad)  
     406:	ff                   	(bad)  
     407:	ff                   	(bad)  
     408:	ff                   	(bad)  
     409:	ff                   	(bad)  
     40a:	ff                   	(bad)  
     40b:	ff                   	(bad)  
     40c:	ff                   	(bad)  
     40d:	ff                   	(bad)  
     40e:	ff                   	(bad)  
     40f:	ff                   	(bad)  
     410:	ff                   	(bad)  
     411:	ff                   	(bad)  
     412:	ff                   	(bad)  
     413:	ff                   	(bad)  
     414:	ff                   	(bad)  
     415:	ff                   	(bad)  
     416:	ff                   	(bad)  
     417:	ff                   	(bad)  
     418:	ff                   	(bad)  
     419:	ff                   	(bad)  
     41a:	ff                   	(bad)  
     41b:	ff                   	(bad)  
     41c:	ff                   	(bad)  
     41d:	ff                   	(bad)  
     41e:	ff                   	(bad)  
     41f:	ff                   	(bad)  
     420:	ff                   	(bad)  
     421:	ff                   	(bad)  
     422:	ff                   	(bad)  
     423:	ff                   	(bad)  
     424:	ff                   	(bad)  
     425:	ff                   	(bad)  
     426:	ff                   	(bad)  
     427:	ff                   	(bad)  
     428:	ff                   	(bad)  
     429:	ff                   	(bad)  
     42a:	ff                   	(bad)  
     42b:	ff                   	(bad)  
     42c:	ff                   	(bad)  
     42d:	ff                   	(bad)  
     42e:	ff                   	(bad)  
     42f:	ff                   	(bad)  
     430:	ff                   	(bad)  
     431:	ff                   	(bad)  
     432:	ff                   	(bad)  
     433:	ff                   	(bad)  
     434:	ff                   	(bad)  
     435:	ff                   	(bad)  
     436:	ff                   	(bad)  
     437:	ff                   	(bad)  
     438:	ff                   	(bad)  
     439:	ff                   	(bad)  
     43a:	ff                   	(bad)  
     43b:	ff                   	(bad)  
     43c:	ff                   	(bad)  
     43d:	ff                   	(bad)  
     43e:	ff                   	(bad)  
     43f:	ff                   	(bad)  
     440:	ff                   	(bad)  
     441:	ff                   	(bad)  
     442:	ff                   	(bad)  
     443:	ff                   	(bad)  
     444:	ff                   	(bad)  
     445:	ff                   	(bad)  
     446:	ff                   	(bad)  
     447:	ff                   	(bad)  
     448:	ff                   	(bad)  
     449:	ff                   	(bad)  
     44a:	ff                   	(bad)  
     44b:	ff                   	(bad)  
     44c:	ff                   	(bad)  
     44d:	ff                   	(bad)  
     44e:	ff                   	(bad)  
     44f:	ff                   	(bad)  
     450:	ff                   	(bad)  
     451:	ff                   	(bad)  
     452:	ff                   	(bad)  
     453:	ff                   	(bad)  
     454:	ff                   	(bad)  
     455:	ff                   	(bad)  
     456:	ff                   	(bad)  
     457:	ff                   	(bad)  
     458:	ff                   	(bad)  
     459:	ff                   	(bad)  
     45a:	ff                   	(bad)  
     45b:	ff                   	(bad)  
     45c:	ff                   	(bad)  
     45d:	ff                   	(bad)  
     45e:	ff                   	(bad)  
     45f:	ff                   	(bad)  
     460:	ff                   	(bad)  
     461:	ff                   	(bad)  
     462:	ff                   	(bad)  
     463:	ff                   	(bad)  
     464:	ff                   	(bad)  
     465:	ff                   	(bad)  
     466:	ff                   	(bad)  
     467:	ff                   	(bad)  
     468:	ff                   	(bad)  
     469:	ff                   	(bad)  
     46a:	ff                   	(bad)  
     46b:	ff                   	(bad)  
     46c:	ff                   	(bad)  
     46d:	ff                   	(bad)  
     46e:	ff                   	(bad)  
     46f:	ff                   	(bad)  
     470:	ff                   	(bad)  
     471:	ff                   	(bad)  
     472:	ff                   	(bad)  
     473:	ff                   	(bad)  
     474:	ff                   	(bad)  
     475:	ff                   	(bad)  
     476:	ff                   	(bad)  
     477:	ff                   	(bad)  
     478:	ff                   	(bad)  
     479:	ff                   	(bad)  
     47a:	ff                   	(bad)  
     47b:	ff                   	(bad)  
     47c:	ff                   	(bad)  
     47d:	ff                   	(bad)  
     47e:	ff                   	(bad)  
     47f:	ff                   	(bad)  
     480:	ff                   	(bad)  
     481:	ff                   	(bad)  
     482:	ff                   	(bad)  
     483:	ff                   	(bad)  
     484:	ff                   	(bad)  
     485:	ff                   	(bad)  
     486:	ff                   	(bad)  
     487:	ff                   	(bad)  
     488:	ff                   	(bad)  
     489:	ff                   	(bad)  
     48a:	ff                   	(bad)  
     48b:	ff                   	(bad)  
     48c:	ff                   	(bad)  
     48d:	ff                   	(bad)  
     48e:	ff                   	(bad)  
     48f:	ff                   	(bad)  
     490:	ff                   	(bad)  
     491:	ff                   	(bad)  
     492:	ff                   	(bad)  
     493:	ff                   	(bad)  
     494:	ff                   	(bad)  
     495:	ff                   	(bad)  
     496:	ff                   	(bad)  
     497:	ff                   	(bad)  
     498:	ff                   	(bad)  
     499:	ff                   	(bad)  
     49a:	ff                   	(bad)  
     49b:	ff                   	(bad)  
     49c:	ff                   	(bad)  
     49d:	ff                   	(bad)  
     49e:	ff                   	(bad)  
     49f:	ff                   	(bad)  
     4a0:	ff                   	(bad)  
     4a1:	ff                   	(bad)  
     4a2:	ff                   	(bad)  
     4a3:	ff                   	(bad)  
     4a4:	ff                   	(bad)  
     4a5:	ff                   	(bad)  
     4a6:	ff                   	(bad)  
     4a7:	ff                   	(bad)  
     4a8:	ff                   	(bad)  
     4a9:	ff                   	(bad)  
     4aa:	ff                   	(bad)  
     4ab:	ff                   	(bad)  
     4ac:	ff                   	(bad)  
     4ad:	ff                   	(bad)  
     4ae:	ff                   	(bad)  
     4af:	ff                   	(bad)  
     4b0:	ff                   	(bad)  
     4b1:	ff                   	(bad)  
     4b2:	ff                   	(bad)  
     4b3:	ff                   	(bad)  
     4b4:	ff                   	(bad)  
     4b5:	ff                   	(bad)  
     4b6:	ff                   	(bad)  
     4b7:	ff                   	(bad)  
     4b8:	ff                   	(bad)  
     4b9:	ff                   	(bad)  
     4ba:	ff                   	(bad)  
     4bb:	ff                   	(bad)  
     4bc:	ff                   	(bad)  
     4bd:	ff                   	(bad)  
     4be:	ff                   	(bad)  
     4bf:	ff                   	(bad)  
     4c0:	ff                   	(bad)  
     4c1:	ff                   	(bad)  
     4c2:	ff                   	(bad)  
     4c3:	ff                   	(bad)  
     4c4:	ff                   	(bad)  
     4c5:	ff                   	(bad)  
     4c6:	ff                   	(bad)  
     4c7:	ff                   	(bad)  
     4c8:	ff                   	(bad)  
     4c9:	ff                   	(bad)  
     4ca:	ff                   	(bad)  
     4cb:	ff                   	(bad)  
     4cc:	ff                   	(bad)  
     4cd:	ff                   	(bad)  
     4ce:	ff                   	(bad)  
     4cf:	ff                   	(bad)  
     4d0:	ff                   	(bad)  
     4d1:	ff                   	(bad)  
     4d2:	ff                   	(bad)  
     4d3:	ff                   	(bad)  
     4d4:	ff                   	(bad)  
     4d5:	ff                   	(bad)  
     4d6:	ff                   	(bad)  
     4d7:	ff                   	(bad)  
     4d8:	ff                   	(bad)  
     4d9:	ff                   	(bad)  
     4da:	ff                   	(bad)  
     4db:	ff                   	(bad)  
     4dc:	ff                   	(bad)  
     4dd:	ff                   	(bad)  
     4de:	ff                   	(bad)  
     4df:	ff                   	(bad)  
     4e0:	ff                   	(bad)  
     4e1:	ff                   	(bad)  
     4e2:	ff                   	(bad)  
     4e3:	ff                   	(bad)  
     4e4:	ff                   	(bad)  
     4e5:	ff                   	(bad)  
     4e6:	ff                   	(bad)  
     4e7:	ff                   	(bad)  
     4e8:	ff                   	(bad)  
     4e9:	ff                   	(bad)  
     4ea:	ff                   	(bad)  
     4eb:	ff                   	(bad)  
     4ec:	ff                   	(bad)  
     4ed:	ff                   	(bad)  
     4ee:	ff                   	(bad)  
     4ef:	ff                   	(bad)  
     4f0:	ff                   	(bad)  
     4f1:	ff                   	(bad)  
     4f2:	ff                   	(bad)  
     4f3:	ff                   	(bad)  
     4f4:	ff                   	(bad)  
     4f5:	ff                   	(bad)  
     4f6:	ff                   	(bad)  
     4f7:	ff                   	(bad)  
     4f8:	ff                   	(bad)  
     4f9:	ff                   	(bad)  
     4fa:	ff                   	(bad)  
     4fb:	ff                   	(bad)  
     4fc:	ff                   	(bad)  
     4fd:	ff                   	(bad)  
     4fe:	ff                   	(bad)  
     4ff:	ff                   	(bad)  
     500:	ff                   	(bad)  
     501:	ff                   	(bad)  
     502:	ff                   	(bad)  
     503:	ff                   	(bad)  
     504:	ff                   	(bad)  
     505:	ff                   	(bad)  
     506:	ff                   	(bad)  
     507:	ff                   	(bad)  
     508:	ff                   	(bad)  
     509:	ff                   	(bad)  
     50a:	ff                   	(bad)  
     50b:	ff                   	(bad)  
     50c:	ff                   	(bad)  
     50d:	ff                   	(bad)  
     50e:	ff                   	(bad)  
     50f:	ff                   	(bad)  
     510:	ff                   	(bad)  
     511:	ff                   	(bad)  
     512:	ff                   	(bad)  
     513:	ff                   	(bad)  
     514:	ff                   	(bad)  
     515:	ff                   	(bad)  
     516:	ff                   	(bad)  
     517:	ff                   	(bad)  
     518:	ff                   	(bad)  
     519:	ff                   	(bad)  
     51a:	ff                   	(bad)  
     51b:	ff                   	(bad)  
     51c:	ff                   	(bad)  
     51d:	ff                   	(bad)  
     51e:	ff                   	(bad)  
     51f:	ff                   	(bad)  
     520:	ff                   	(bad)  
     521:	ff                   	(bad)  
     522:	ff                   	(bad)  
     523:	ff                   	(bad)  
     524:	ff                   	(bad)  
     525:	ff                   	(bad)  
     526:	ff                   	(bad)  
     527:	ff                   	(bad)  
     528:	ff                   	(bad)  
     529:	ff                   	(bad)  
     52a:	ff                   	(bad)  
     52b:	ff                   	(bad)  
     52c:	ff                   	(bad)  
     52d:	ff                   	(bad)  
     52e:	ff                   	(bad)  
     52f:	ff                   	(bad)  
     530:	ff                   	(bad)  
     531:	ff                   	(bad)  
     532:	ff                   	(bad)  
     533:	ff                   	(bad)  
     534:	ff                   	(bad)  
     535:	ff                   	(bad)  
     536:	ff                   	(bad)  
     537:	ff                   	(bad)  
     538:	ff                   	(bad)  
     539:	ff                   	(bad)  
     53a:	ff                   	(bad)  
     53b:	ff                   	(bad)  
     53c:	ff                   	(bad)  
     53d:	ff                   	(bad)  
     53e:	ff                   	(bad)  
     53f:	ff                   	(bad)  
     540:	ff                   	(bad)  
     541:	ff                   	(bad)  
     542:	ff                   	(bad)  
     543:	ff                   	(bad)  
     544:	ff                   	(bad)  
     545:	ff                   	(bad)  
     546:	ff                   	(bad)  
     547:	ff                   	(bad)  
     548:	ff                   	(bad)  
     549:	ff                   	(bad)  
     54a:	ff                   	(bad)  
     54b:	ff                   	(bad)  
     54c:	ff                   	(bad)  
     54d:	ff                   	(bad)  
     54e:	ff                   	(bad)  
     54f:	ff                   	(bad)  
     550:	ff                   	(bad)  
     551:	ff                   	(bad)  
     552:	ff                   	(bad)  
     553:	ff                   	(bad)  
     554:	ff                   	(bad)  
     555:	ff                   	(bad)  
     556:	ff                   	(bad)  
     557:	ff                   	(bad)  
     558:	ff                   	(bad)  
     559:	ff                   	(bad)  
     55a:	ff                   	(bad)  
     55b:	ff                   	(bad)  
     55c:	ff                   	(bad)  
     55d:	ff                   	(bad)  
     55e:	ff                   	(bad)  
     55f:	ff                   	(bad)  
     560:	ff                   	(bad)  
     561:	ff                   	(bad)  
     562:	ff                   	(bad)  
     563:	ff                   	(bad)  
     564:	ff                   	(bad)  
     565:	ff                   	(bad)  
     566:	ff                   	(bad)  
     567:	ff                   	(bad)  
     568:	ff                   	(bad)  
     569:	ff                   	(bad)  
     56a:	ff                   	(bad)  
     56b:	ff                   	(bad)  
     56c:	ff                   	(bad)  
     56d:	ff                   	(bad)  
     56e:	ff                   	(bad)  
     56f:	ff                   	(bad)  
     570:	ff                   	(bad)  
     571:	ff                   	(bad)  
     572:	ff                   	(bad)  
     573:	ff                   	(bad)  
     574:	ff                   	(bad)  
     575:	ff                   	(bad)  
     576:	ff                   	(bad)  
     577:	ff                   	(bad)  
     578:	ff                   	(bad)  
     579:	ff                   	(bad)  
     57a:	ff                   	(bad)  
     57b:	ff                   	(bad)  
     57c:	ff                   	(bad)  
     57d:	ff                   	(bad)  
     57e:	ff                   	(bad)  
     57f:	ff                   	(bad)  
     580:	ff                   	(bad)  
     581:	ff                   	(bad)  
     582:	ff                   	(bad)  
     583:	ff                   	(bad)  
     584:	ff                   	(bad)  
     585:	ff                   	(bad)  
     586:	ff                   	(bad)  
     587:	ff                   	(bad)  
     588:	ff                   	(bad)  
     589:	ff                   	(bad)  
     58a:	ff                   	(bad)  
     58b:	ff                   	(bad)  
     58c:	ff                   	(bad)  
     58d:	ff                   	(bad)  
     58e:	ff                   	(bad)  
     58f:	ff                   	(bad)  
     590:	ff                   	(bad)  
     591:	ff                   	(bad)  
     592:	ff                   	(bad)  
     593:	ff                   	(bad)  
     594:	ff                   	(bad)  
     595:	ff                   	(bad)  
     596:	ff                   	(bad)  
     597:	ff                   	(bad)  
     598:	ff                   	(bad)  
     599:	ff                   	(bad)  
     59a:	ff                   	(bad)  
     59b:	ff                   	(bad)  
     59c:	ff                   	(bad)  
     59d:	ff                   	(bad)  
     59e:	ff                   	(bad)  
     59f:	ff                   	(bad)  
     5a0:	ff                   	(bad)  
     5a1:	ff                   	(bad)  
     5a2:	ff                   	(bad)  
     5a3:	ff                   	(bad)  
     5a4:	ff                   	(bad)  
     5a5:	ff                   	(bad)  
     5a6:	ff                   	(bad)  
     5a7:	ff                   	(bad)  
     5a8:	ff                   	(bad)  
     5a9:	ff                   	(bad)  
     5aa:	ff                   	(bad)  
     5ab:	ff                   	(bad)  
     5ac:	ff                   	(bad)  
     5ad:	ff                   	(bad)  
     5ae:	ff                   	(bad)  
     5af:	ff                   	(bad)  
     5b0:	ff                   	(bad)  
     5b1:	ff                   	(bad)  
     5b2:	ff                   	(bad)  
     5b3:	ff                   	(bad)  
     5b4:	ff                   	(bad)  
     5b5:	ff                   	(bad)  
     5b6:	ff                   	(bad)  
     5b7:	ff                   	(bad)  
     5b8:	ff                   	(bad)  
     5b9:	ff                   	(bad)  
     5ba:	ff                   	(bad)  
     5bb:	ff                   	(bad)  
     5bc:	ff                   	(bad)  
     5bd:	ff                   	(bad)  
     5be:	ff                   	(bad)  
     5bf:	ff                   	(bad)  
     5c0:	ff                   	(bad)  
     5c1:	ff                   	(bad)  
     5c2:	ff                   	(bad)  
     5c3:	ff                   	(bad)  
     5c4:	ff                   	(bad)  
     5c5:	ff                   	(bad)  
     5c6:	ff                   	(bad)  
     5c7:	ff                   	(bad)  
     5c8:	ff                   	(bad)  
     5c9:	ff                   	(bad)  
     5ca:	ff                   	(bad)  
     5cb:	ff                   	(bad)  
     5cc:	ff                   	(bad)  
     5cd:	ff                   	(bad)  
     5ce:	ff                   	(bad)  
     5cf:	ff                   	(bad)  
     5d0:	ff                   	(bad)  
     5d1:	ff                   	(bad)  
     5d2:	ff                   	(bad)  
     5d3:	ff                   	(bad)  
     5d4:	ff                   	(bad)  
     5d5:	ff                   	(bad)  
     5d6:	ff                   	(bad)  
     5d7:	ff                   	(bad)  
     5d8:	ff                   	(bad)  
     5d9:	ff                   	(bad)  
     5da:	ff                   	(bad)  
     5db:	ff                   	(bad)  
     5dc:	ff                   	(bad)  
     5dd:	ff                   	(bad)  
     5de:	ff                   	(bad)  
     5df:	ff                   	(bad)  
     5e0:	ff                   	(bad)  
     5e1:	ff                   	(bad)  
     5e2:	ff                   	(bad)  
     5e3:	ff                   	(bad)  
     5e4:	ff                   	(bad)  
     5e5:	ff                   	(bad)  
     5e6:	ff                   	(bad)  
     5e7:	ff                   	(bad)  
     5e8:	ff                   	(bad)  
     5e9:	ff                   	(bad)  
     5ea:	ff                   	(bad)  
     5eb:	ff                   	(bad)  
     5ec:	ff                   	(bad)  
     5ed:	ff                   	(bad)  
     5ee:	ff                   	(bad)  
     5ef:	ff                   	(bad)  
     5f0:	ff                   	(bad)  
     5f1:	ff                   	(bad)  
     5f2:	ff                   	(bad)  
     5f3:	ff                   	(bad)  
     5f4:	ff                   	(bad)  
     5f5:	ff                   	(bad)  
     5f6:	ff                   	(bad)  
     5f7:	ff                   	(bad)  
     5f8:	ff                   	(bad)  
     5f9:	ff                   	(bad)  
     5fa:	ff                   	(bad)  
     5fb:	ff                   	(bad)  
     5fc:	ff                   	(bad)  
     5fd:	ff                   	(bad)  
     5fe:	ff                   	(bad)  
     5ff:	ff                   	(bad)  
     600:	ff                   	(bad)  
     601:	ff                   	(bad)  
     602:	ff                   	(bad)  
     603:	ff                   	(bad)  
     604:	ff                   	(bad)  
     605:	ff                   	(bad)  
     606:	ff                   	(bad)  
     607:	ff                   	(bad)  
     608:	ff                   	(bad)  
     609:	ff                   	(bad)  
     60a:	ff                   	(bad)  
     60b:	ff                   	(bad)  
     60c:	ff                   	(bad)  
     60d:	ff                   	(bad)  
     60e:	ff                   	(bad)  
     60f:	ff                   	(bad)  
     610:	ff                   	(bad)  
     611:	ff                   	(bad)  
     612:	ff                   	(bad)  
     613:	ff                   	(bad)  
     614:	ff                   	(bad)  
     615:	ff                   	(bad)  
     616:	ff                   	(bad)  
     617:	ff                   	(bad)  
     618:	ff                   	(bad)  
     619:	ff                   	(bad)  
     61a:	ff                   	(bad)  
     61b:	ff                   	(bad)  
     61c:	ff                   	(bad)  
     61d:	ff                   	(bad)  
     61e:	ff                   	(bad)  
     61f:	ff                   	(bad)  
     620:	ff                   	(bad)  
     621:	ff                   	(bad)  
     622:	ff                   	(bad)  
     623:	ff                   	(bad)  
     624:	ff                   	(bad)  
     625:	ff                   	(bad)  
     626:	ff                   	(bad)  
     627:	ff                   	(bad)  
     628:	ff                   	(bad)  
     629:	ff                   	(bad)  
     62a:	ff                   	(bad)  
     62b:	ff                   	(bad)  
     62c:	ff                   	(bad)  
     62d:	ff                   	(bad)  
     62e:	ff                   	(bad)  
     62f:	ff                   	(bad)  
     630:	ff                   	(bad)  
     631:	ff                   	(bad)  
     632:	ff                   	(bad)  
     633:	ff                   	(bad)  
     634:	ff                   	(bad)  
     635:	ff                   	(bad)  
     636:	ff                   	(bad)  
     637:	ff                   	(bad)  
     638:	ff                   	(bad)  
     639:	ff                   	(bad)  
     63a:	ff                   	(bad)  
     63b:	ff                   	(bad)  
     63c:	ff                   	(bad)  
     63d:	ff                   	(bad)  
     63e:	ff                   	(bad)  
     63f:	ff                   	(bad)  
     640:	ff                   	(bad)  
     641:	ff                   	(bad)  
     642:	ff                   	(bad)  
     643:	ff                   	(bad)  
     644:	ff                   	(bad)  
     645:	ff                   	(bad)  
     646:	ff                   	(bad)  
     647:	ff                   	(bad)  
     648:	ff                   	(bad)  
     649:	ff                   	(bad)  
     64a:	ff                   	(bad)  
     64b:	ff                   	(bad)  
     64c:	ff                   	(bad)  
     64d:	ff                   	(bad)  
     64e:	ff                   	(bad)  
     64f:	ff                   	(bad)  
     650:	ff                   	(bad)  
     651:	ff                   	(bad)  
     652:	ff                   	(bad)  
     653:	ff                   	(bad)  
     654:	ff                   	(bad)  
     655:	ff                   	(bad)  
     656:	ff                   	(bad)  
     657:	ff                   	(bad)  
     658:	ff                   	(bad)  
     659:	ff                   	(bad)  
     65a:	ff                   	(bad)  
     65b:	ff                   	(bad)  
     65c:	ff                   	(bad)  
     65d:	ff                   	(bad)  
     65e:	ff                   	(bad)  
     65f:	ff                   	(bad)  
     660:	ff                   	(bad)  
     661:	ff                   	(bad)  
     662:	ff                   	(bad)  
     663:	ff                   	(bad)  
     664:	ff                   	(bad)  
     665:	ff                   	(bad)  
     666:	ff                   	(bad)  
     667:	ff                   	(bad)  
     668:	ff                   	(bad)  
     669:	ff                   	(bad)  
     66a:	ff                   	(bad)  
     66b:	ff                   	(bad)  
     66c:	ff                   	(bad)  
     66d:	ff                   	(bad)  
     66e:	ff                   	(bad)  
     66f:	ff                   	(bad)  
     670:	ff                   	(bad)  
     671:	ff                   	(bad)  
     672:	ff                   	(bad)  
     673:	ff                   	(bad)  
     674:	ff                   	(bad)  
     675:	ff                   	(bad)  
     676:	ff                   	(bad)  
     677:	ff                   	(bad)  
     678:	ff                   	(bad)  
     679:	ff                   	(bad)  
     67a:	ff                   	(bad)  
     67b:	ff                   	(bad)  
     67c:	ff                   	(bad)  
     67d:	ff                   	(bad)  
     67e:	ff                   	(bad)  
     67f:	ff                   	(bad)  
     680:	ff                   	(bad)  
     681:	ff                   	(bad)  
     682:	ff                   	(bad)  
     683:	ff                   	(bad)  
     684:	ff                   	(bad)  
     685:	ff                   	(bad)  
     686:	ff                   	(bad)  
     687:	ff                   	(bad)  
     688:	ff                   	(bad)  
     689:	ff                   	(bad)  
     68a:	ff                   	(bad)  
     68b:	ff                   	(bad)  
     68c:	ff                   	(bad)  
     68d:	ff                   	(bad)  
     68e:	ff                   	(bad)  
     68f:	ff                   	(bad)  
     690:	ff                   	(bad)  
     691:	ff                   	(bad)  
     692:	ff                   	(bad)  
     693:	ff                   	(bad)  
     694:	ff                   	(bad)  
     695:	ff                   	(bad)  
     696:	ff                   	(bad)  
     697:	ff                   	(bad)  
     698:	ff                   	(bad)  
     699:	ff                   	(bad)  
     69a:	ff                   	(bad)  
     69b:	ff                   	(bad)  
     69c:	ff                   	(bad)  
     69d:	ff                   	(bad)  
     69e:	ff                   	(bad)  
     69f:	ff                   	(bad)  
     6a0:	ff                   	(bad)  
     6a1:	ff                   	(bad)  
     6a2:	ff                   	(bad)  
     6a3:	ff                   	(bad)  
     6a4:	ff                   	(bad)  
     6a5:	ff                   	(bad)  
     6a6:	ff                   	(bad)  
     6a7:	ff                   	(bad)  
     6a8:	ff                   	(bad)  
     6a9:	ff                   	(bad)  
     6aa:	ff                   	(bad)  
     6ab:	ff                   	(bad)  
     6ac:	ff                   	(bad)  
     6ad:	ff                   	(bad)  
     6ae:	ff                   	(bad)  
     6af:	ff                   	(bad)  
     6b0:	ff                   	(bad)  
     6b1:	ff                   	(bad)  
     6b2:	ff                   	(bad)  
     6b3:	ff                   	(bad)  
     6b4:	ff                   	(bad)  
     6b5:	ff                   	(bad)  
     6b6:	ff                   	(bad)  
     6b7:	ff                   	(bad)  
     6b8:	ff                   	(bad)  
     6b9:	ff                   	(bad)  
     6ba:	ff                   	(bad)  
     6bb:	ff                   	(bad)  
     6bc:	ff                   	(bad)  
     6bd:	ff                   	(bad)  
     6be:	ff                   	(bad)  
     6bf:	ff                   	(bad)  
     6c0:	ff                   	(bad)  
     6c1:	ff                   	(bad)  
     6c2:	ff                   	(bad)  
     6c3:	ff                   	(bad)  
     6c4:	ff                   	(bad)  
     6c5:	ff                   	(bad)  
     6c6:	ff                   	(bad)  
     6c7:	ff                   	(bad)  
     6c8:	ff                   	(bad)  
     6c9:	ff                   	(bad)  
     6ca:	ff                   	(bad)  
     6cb:	ff                   	(bad)  
     6cc:	ff                   	(bad)  
     6cd:	ff                   	(bad)  
     6ce:	ff                   	(bad)  
     6cf:	ff                   	(bad)  
     6d0:	ff                   	(bad)  
     6d1:	ff                   	(bad)  
     6d2:	ff                   	(bad)  
     6d3:	ff                   	(bad)  
     6d4:	ff                   	(bad)  
     6d5:	ff                   	(bad)  
     6d6:	ff                   	(bad)  
     6d7:	ff                   	(bad)  
     6d8:	ff                   	(bad)  
     6d9:	ff                   	(bad)  
     6da:	ff                   	(bad)  
     6db:	ff                   	(bad)  
     6dc:	ff                   	(bad)  
     6dd:	ff                   	(bad)  
     6de:	ff                   	(bad)  
     6df:	ff                   	(bad)  
     6e0:	ff                   	(bad)  
     6e1:	ff                   	(bad)  
     6e2:	ff                   	(bad)  
     6e3:	ff                   	(bad)  
     6e4:	ff                   	(bad)  
     6e5:	ff                   	(bad)  
     6e6:	ff                   	(bad)  
     6e7:	ff                   	(bad)  
     6e8:	ff                   	(bad)  
     6e9:	ff                   	(bad)  
     6ea:	ff                   	(bad)  
     6eb:	ff                   	(bad)  
     6ec:	ff                   	(bad)  
     6ed:	ff                   	(bad)  
     6ee:	ff                   	(bad)  
     6ef:	ff                   	(bad)  
     6f0:	ff                   	(bad)  
     6f1:	ff                   	(bad)  
     6f2:	ff                   	(bad)  
     6f3:	ff                   	(bad)  
     6f4:	ff                   	(bad)  
     6f5:	ff                   	(bad)  
     6f6:	ff                   	(bad)  
     6f7:	ff                   	(bad)  
     6f8:	ff                   	(bad)  
     6f9:	ff                   	(bad)  
     6fa:	ff                   	(bad)  
     6fb:	ff                   	(bad)  
     6fc:	ff                   	(bad)  
     6fd:	ff                   	(bad)  
     6fe:	ff                   	(bad)  
     6ff:	ff                   	(bad)  
     700:	ff                   	(bad)  
     701:	ff                   	(bad)  
     702:	ff                   	(bad)  
     703:	ff                   	(bad)  
     704:	ff                   	(bad)  
     705:	ff                   	(bad)  
     706:	ff                   	(bad)  
     707:	ff                   	(bad)  
     708:	ff                   	(bad)  
     709:	ff                   	(bad)  
     70a:	ff                   	(bad)  
     70b:	ff                   	(bad)  
     70c:	ff                   	(bad)  
     70d:	ff                   	(bad)  
     70e:	ff                   	(bad)  
     70f:	ff                   	(bad)  
     710:	ff                   	(bad)  
     711:	ff                   	(bad)  
     712:	ff                   	(bad)  
     713:	ff                   	(bad)  
     714:	ff                   	(bad)  
     715:	ff                   	(bad)  
     716:	ff                   	(bad)  
     717:	ff                   	(bad)  
     718:	ff                   	(bad)  
     719:	ff                   	(bad)  
     71a:	ff                   	(bad)  
     71b:	ff                   	(bad)  
     71c:	ff                   	(bad)  
     71d:	ff                   	(bad)  
     71e:	ff                   	(bad)  
     71f:	ff                   	(bad)  
     720:	ff                   	(bad)  
     721:	ff                   	(bad)  
     722:	ff                   	(bad)  
     723:	ff                   	(bad)  
     724:	ff                   	(bad)  
     725:	ff                   	(bad)  
     726:	ff                   	(bad)  
     727:	ff                   	(bad)  
     728:	ff                   	(bad)  
     729:	ff                   	(bad)  
     72a:	ff                   	(bad)  
     72b:	ff                   	(bad)  
     72c:	ff                   	(bad)  
     72d:	ff                   	(bad)  
     72e:	ff                   	(bad)  
     72f:	ff                   	(bad)  
     730:	ff                   	(bad)  
     731:	ff                   	(bad)  
     732:	ff                   	(bad)  
     733:	ff                   	(bad)  
     734:	ff                   	(bad)  
     735:	ff                   	(bad)  
     736:	ff                   	(bad)  
     737:	ff                   	(bad)  
     738:	ff                   	(bad)  
     739:	ff                   	(bad)  
     73a:	ff                   	(bad)  
     73b:	ff                   	(bad)  
     73c:	ff                   	(bad)  
     73d:	ff                   	(bad)  
     73e:	ff                   	(bad)  
     73f:	ff                   	(bad)  
     740:	ff                   	(bad)  
     741:	ff                   	(bad)  
     742:	ff                   	(bad)  
     743:	ff                   	(bad)  
     744:	ff                   	(bad)  
     745:	ff                   	(bad)  
     746:	ff                   	(bad)  
     747:	ff                   	(bad)  
     748:	ff                   	(bad)  
     749:	ff                   	(bad)  
     74a:	ff                   	(bad)  
     74b:	ff                   	(bad)  
     74c:	ff                   	(bad)  
     74d:	ff                   	(bad)  
     74e:	ff                   	(bad)  
     74f:	ff                   	(bad)  
     750:	ff                   	(bad)  
     751:	ff                   	(bad)  
     752:	ff                   	(bad)  
     753:	ff                   	(bad)  
     754:	ff                   	(bad)  
     755:	ff                   	(bad)  
     756:	ff                   	(bad)  
     757:	ff                   	(bad)  
     758:	ff                   	(bad)  
     759:	ff                   	(bad)  
     75a:	ff                   	(bad)  
     75b:	ff                   	(bad)  
     75c:	ff                   	(bad)  
     75d:	ff                   	(bad)  
     75e:	ff                   	(bad)  
     75f:	ff                   	(bad)  
     760:	ff                   	(bad)  
     761:	ff                   	(bad)  
     762:	ff                   	(bad)  
     763:	ff                   	(bad)  
     764:	ff                   	(bad)  
     765:	ff                   	(bad)  
     766:	ff                   	(bad)  
     767:	ff                   	(bad)  
     768:	ff                   	(bad)  
     769:	ff                   	(bad)  
     76a:	ff                   	(bad)  
     76b:	ff                   	(bad)  
     76c:	ff                   	(bad)  
     76d:	ff                   	(bad)  
     76e:	ff                   	(bad)  
     76f:	ff                   	(bad)  
     770:	ff                   	(bad)  
     771:	ff                   	(bad)  
     772:	ff                   	(bad)  
     773:	ff                   	(bad)  
     774:	ff                   	(bad)  
     775:	ff                   	(bad)  
     776:	ff                   	(bad)  
     777:	ff                   	(bad)  
     778:	ff                   	(bad)  
     779:	ff                   	(bad)  
     77a:	ff                   	(bad)  
     77b:	ff                   	(bad)  
     77c:	ff                   	(bad)  
     77d:	ff                   	(bad)  
     77e:	ff                   	(bad)  
     77f:	ff                   	(bad)  
     780:	ff                   	(bad)  
     781:	ff                   	(bad)  
     782:	ff                   	(bad)  
     783:	ff                   	(bad)  
     784:	ff                   	(bad)  
     785:	ff                   	(bad)  
     786:	ff                   	(bad)  
     787:	ff                   	(bad)  
     788:	ff                   	(bad)  
     789:	ff                   	(bad)  
     78a:	ff                   	(bad)  
     78b:	ff                   	(bad)  
     78c:	ff                   	(bad)  
     78d:	ff                   	(bad)  
     78e:	ff                   	(bad)  
     78f:	ff                   	(bad)  
     790:	ff                   	(bad)  
     791:	ff                   	(bad)  
     792:	ff                   	(bad)  
     793:	ff                   	(bad)  
     794:	ff                   	(bad)  
     795:	ff                   	(bad)  
     796:	ff                   	(bad)  
     797:	ff                   	(bad)  
     798:	ff                   	(bad)  
     799:	ff                   	(bad)  
     79a:	ff                   	(bad)  
     79b:	ff                   	(bad)  
     79c:	ff                   	(bad)  
     79d:	ff                   	(bad)  
     79e:	ff                   	(bad)  
     79f:	ff                   	(bad)  
     7a0:	ff                   	(bad)  
     7a1:	ff                   	(bad)  
     7a2:	ff                   	(bad)  
     7a3:	ff                   	(bad)  
     7a4:	ff                   	(bad)  
     7a5:	ff                   	(bad)  
     7a6:	ff                   	(bad)  
     7a7:	ff                   	(bad)  
     7a8:	ff                   	(bad)  
     7a9:	ff                   	(bad)  
     7aa:	ff                   	(bad)  
     7ab:	ff                   	(bad)  
     7ac:	ff                   	(bad)  
     7ad:	ff                   	(bad)  
     7ae:	ff                   	(bad)  
     7af:	ff                   	(bad)  
     7b0:	ff                   	(bad)  
     7b1:	ff                   	(bad)  
     7b2:	ff                   	(bad)  
     7b3:	ff                   	(bad)  
     7b4:	ff                   	(bad)  
     7b5:	ff                   	(bad)  
     7b6:	ff                   	(bad)  
     7b7:	ff                   	(bad)  
     7b8:	ff                   	(bad)  
     7b9:	ff                   	(bad)  
     7ba:	ff                   	(bad)  
     7bb:	ff                   	(bad)  
     7bc:	ff                   	(bad)  
     7bd:	ff                   	(bad)  
     7be:	ff                   	(bad)  
     7bf:	ff                   	(bad)  
     7c0:	ff                   	(bad)  
     7c1:	ff                   	(bad)  
     7c2:	ff                   	(bad)  
     7c3:	ff                   	(bad)  
     7c4:	ff                   	(bad)  
     7c5:	ff                   	(bad)  
     7c6:	ff                   	(bad)  
     7c7:	ff                   	(bad)  
     7c8:	ff                   	(bad)  
     7c9:	ff                   	(bad)  
     7ca:	ff                   	(bad)  
     7cb:	ff                   	(bad)  
     7cc:	ff                   	(bad)  
     7cd:	ff                   	(bad)  
     7ce:	ff                   	(bad)  
     7cf:	ff                   	(bad)  
     7d0:	ff                   	(bad)  
     7d1:	ff                   	(bad)  
     7d2:	ff                   	(bad)  
     7d3:	ff                   	(bad)  
     7d4:	ff                   	(bad)  
     7d5:	ff                   	(bad)  
     7d6:	ff                   	(bad)  
     7d7:	ff                   	(bad)  
     7d8:	ff                   	(bad)  
     7d9:	ff                   	(bad)  
     7da:	ff                   	(bad)  
     7db:	ff                   	(bad)  
     7dc:	ff                   	(bad)  
     7dd:	ff                   	(bad)  
     7de:	ff                   	(bad)  
     7df:	ff                   	(bad)  
     7e0:	ff                   	(bad)  
     7e1:	ff                   	(bad)  
     7e2:	ff                   	(bad)  
     7e3:	ff                   	(bad)  
     7e4:	ff                   	(bad)  
     7e5:	ff                   	(bad)  
     7e6:	ff                   	(bad)  
     7e7:	ff                   	(bad)  
     7e8:	ff                   	(bad)  
     7e9:	ff                   	(bad)  
     7ea:	ff                   	(bad)  
     7eb:	ff                   	(bad)  
     7ec:	ff                   	(bad)  
     7ed:	ff                   	(bad)  
     7ee:	ff                   	(bad)  
     7ef:	ff                   	(bad)  
     7f0:	ff                   	(bad)  
     7f1:	ff                   	(bad)  
     7f2:	ff                   	(bad)  
     7f3:	ff                   	(bad)  
     7f4:	ff                   	(bad)  
     7f5:	ff                   	(bad)  
     7f6:	ff                   	(bad)  
     7f7:	ff                   	(bad)  
     7f8:	ff                   	(bad)  
     7f9:	ff                   	(bad)  
     7fa:	ff                   	(bad)  
     7fb:	ff                   	(bad)  
     7fc:	ff                   	(bad)  
     7fd:	ff                   	(bad)  
     7fe:	ff                   	(bad)  
     7ff:	ff 00                	incw   (%bx,%si)
	...
     821:	00 78 00             	add    %bh,0x0(%bx,%si)
     824:	cc                   	int3   
     825:	00 86 01 86          	add    %al,-0x79ff(%bp)
     829:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     82d:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     831:	01 86 01 cc          	add    %ax,-0x33ff(%bp)
     835:	00 78 00             	add    %bh,0x0(%bx,%si)
     838:	00 00                	add    %al,(%bx,%si)
     83a:	00 00                	add    %al,(%bx,%si)
     83c:	00 80 00 00          	add    %al,0x0(%bx,%si)
     840:	00 00                	add    %al,(%bx,%si)
     842:	30 00                	xor    %al,(%bx,%si)
     844:	38 00                	cmp    %al,(%bx,%si)
     846:	3c 00                	cmp    $0x0,%al
     848:	30 00                	xor    %al,(%bx,%si)
     84a:	30 00                	xor    %al,(%bx,%si)
     84c:	30 00                	xor    %al,(%bx,%si)
     84e:	30 00                	xor    %al,(%bx,%si)
     850:	30 00                	xor    %al,(%bx,%si)
     852:	30 00                	xor    %al,(%bx,%si)
     854:	30 00                	xor    %al,(%bx,%si)
     856:	fc                   	cld    
     857:	00 00                	add    %al,(%bx,%si)
     859:	00 00                	add    %al,(%bx,%si)
     85b:	00 00                	add    %al,(%bx,%si)
     85d:	80 00 00             	addb   $0x0,(%bx,%si)
     860:	00 00                	add    %al,(%bx,%si)
     862:	fc                   	cld    
     863:	00 86 01 80          	add    %al,-0x7fff(%bp)
     867:	01 80 01 c0          	add    %ax,-0x3fff(%bx,%si)
     86b:	00 78 00             	add    %bh,0x0(%bx,%si)
     86e:	0c 00                	or     $0x0,%al
     870:	06                   	push   %es
     871:	00 06 00 86          	add    %al,-0x7a00
     875:	01 fe                	add    %di,%si
     877:	01 00                	add    %ax,(%bx,%si)
     879:	00 00                	add    %al,(%bx,%si)
     87b:	00 00                	add    %al,(%bx,%si)
     87d:	80 00 00             	addb   $0x0,(%bx,%si)
     880:	00 00                	add    %al,(%bx,%si)
     882:	fc                   	cld    
     883:	00 86 01 80          	add    %al,-0x7fff(%bp)
     887:	01 80 01 80          	add    %ax,-0x7fff(%bx,%si)
     88b:	01 f0                	add    %si,%ax
     88d:	00 80 01 80          	add    %al,-0x7fff(%bx,%si)
     891:	01 80 01 86          	add    %ax,-0x79ff(%bx,%si)
     895:	01 fc                	add    %di,%sp
     897:	00 00                	add    %al,(%bx,%si)
     899:	00 00                	add    %al,(%bx,%si)
     89b:	00 00                	add    %al,(%bx,%si)
     89d:	80 00 00             	addb   $0x0,(%bx,%si)
     8a0:	00 00                	add    %al,(%bx,%si)
     8a2:	c0 00 e0             	rolb   $0xe0,(%bx,%si)
     8a5:	00 f0                	add    %dh,%al
     8a7:	00 d8                	add    %bl,%al
     8a9:	00 cc                	add    %cl,%ah
     8ab:	00 c6                	add    %al,%dh
     8ad:	00 fe                	add    %bh,%dh
     8af:	01 c0                	add    %ax,%ax
     8b1:	00 c0                	add    %al,%al
     8b3:	00 c0                	add    %al,%al
     8b5:	00 e0                	add    %ah,%al
     8b7:	01 00                	add    %ax,(%bx,%si)
     8b9:	00 00                	add    %al,(%bx,%si)
     8bb:	00 00                	add    %al,(%bx,%si)
     8bd:	80 00 00             	addb   $0x0,(%bx,%si)
     8c0:	00 00                	add    %al,(%bx,%si)
     8c2:	fe 01                	incb   (%bx,%di)
     8c4:	86 01                	xchg   %al,(%bx,%di)
     8c6:	06                   	push   %es
     8c7:	00 06 00 06          	add    %al,0x600
     8cb:	00 fe                	add    %bh,%dh
     8cd:	00 80 01 80          	add    %al,-0x7fff(%bx,%si)
     8d1:	01 80 01 86          	add    %ax,-0x79ff(%bx,%si)
     8d5:	01 fc                	add    %di,%sp
     8d7:	00 00                	add    %al,(%bx,%si)
     8d9:	00 00                	add    %al,(%bx,%si)
     8db:	00 00                	add    %al,(%bx,%si)
     8dd:	80 00 00             	addb   $0x0,(%bx,%si)
     8e0:	00 00                	add    %al,(%bx,%si)
     8e2:	f0 00 18             	lock add %bl,(%bx,%si)
     8e5:	00 0c                	add    %cl,(%si)
     8e7:	00 06 00 06          	add    %al,0x600
     8eb:	00 fe                	add    %bh,%dh
     8ed:	00 86 01 86          	add    %al,-0x79ff(%bp)
     8f1:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     8f5:	01 fc                	add    %di,%sp
     8f7:	00 00                	add    %al,(%bx,%si)
     8f9:	00 00                	add    %al,(%bx,%si)
     8fb:	00 00                	add    %al,(%bx,%si)
     8fd:	80 00 00             	addb   $0x0,(%bx,%si)
     900:	00 00                	add    %al,(%bx,%si)
     902:	fe 01                	incb   (%bx,%di)
     904:	86 01                	xchg   %al,(%bx,%di)
     906:	80 01 c0             	addb   $0xc0,(%bx,%di)
     909:	00 60 00             	add    %ah,0x0(%bx,%si)
     90c:	30 00                	xor    %al,(%bx,%si)
     90e:	30 00                	xor    %al,(%bx,%si)
     910:	30 00                	xor    %al,(%bx,%si)
     912:	30 00                	xor    %al,(%bx,%si)
     914:	30 00                	xor    %al,(%bx,%si)
     916:	30 00                	xor    %al,(%bx,%si)
     918:	00 00                	add    %al,(%bx,%si)
     91a:	00 00                	add    %al,(%bx,%si)
     91c:	00 80 00 00          	add    %al,0x0(%bx,%si)
     920:	00 00                	add    %al,(%bx,%si)
     922:	fc                   	cld    
     923:	00 86 01 86          	add    %al,-0x79ff(%bp)
     927:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     92b:	01 fc                	add    %di,%sp
     92d:	00 86 01 86          	add    %al,-0x79ff(%bp)
     931:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     935:	01 fc                	add    %di,%sp
     937:	00 00                	add    %al,(%bx,%si)
     939:	00 00                	add    %al,(%bx,%si)
     93b:	00 00                	add    %al,(%bx,%si)
     93d:	80 00 00             	addb   $0x0,(%bx,%si)
     940:	00 00                	add    %al,(%bx,%si)
     942:	fc                   	cld    
     943:	00 86 01 86          	add    %al,-0x79ff(%bp)
     947:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     94b:	01 fc                	add    %di,%sp
     94d:	01 80 01 80          	add    %ax,-0x7fff(%bx,%si)
     951:	01 c0                	add    %ax,%ax
     953:	00 60 00             	add    %ah,0x0(%bx,%si)
     956:	3c 00                	cmp    $0x0,%al
     958:	00 00                	add    %al,(%bx,%si)
     95a:	00 00                	add    %al,(%bx,%si)
     95c:	00 80 00 00          	add    %al,0x0(%bx,%si)
     960:	00 00                	add    %al,(%bx,%si)
     962:	fe 01                	incb   (%bx,%di)
     964:	b6 01                	mov    $0x1,%dh
     966:	32 01                	xor    (%bx,%di),%al
     968:	30 00                	xor    %al,(%bx,%si)
     96a:	30 00                	xor    %al,(%bx,%si)
     96c:	30 00                	xor    %al,(%bx,%si)
     96e:	30 00                	xor    %al,(%bx,%si)
     970:	30 00                	xor    %al,(%bx,%si)
     972:	30 00                	xor    %al,(%bx,%si)
     974:	30 00                	xor    %al,(%bx,%si)
     976:	78 00                	js     0x978
     978:	00 00                	add    %al,(%bx,%si)
     97a:	00 00                	add    %al,(%bx,%si)
     97c:	00 80 00 00          	add    %al,0x0(%bx,%si)
	...
     98c:	f8                   	clc    
     98d:	00 8c 01 fc          	add    %cl,-0x3ff(%si)
     991:	01 0c                	add    %cx,(%si)
     993:	00 8c 01 f8          	add    %cl,-0x7ff(%si)
     997:	00 00                	add    %al,(%bx,%si)
     999:	00 00                	add    %al,(%bx,%si)
     99b:	00 00                	add    %al,(%bx,%si)
     99d:	80 00 00             	addb   $0x0,(%bx,%si)
	...
     9ac:	f8                   	clc    
     9ad:	00 8c 01 38          	add    %cl,0x3801(%si)
     9b1:	00 e0                	add    %ah,%al
     9b3:	00 8c 01 f8          	add    %cl,-0x7ff(%si)
     9b7:	00 00                	add    %al,(%bx,%si)
     9b9:	00 00                	add    %al,(%bx,%si)
     9bb:	00 00                	add    %al,(%bx,%si)
     9bd:	80 00 00             	addb   $0x0,(%bx,%si)
     9c0:	00 00                	add    %al,(%bx,%si)
     9c2:	00 00                	add    %al,(%bx,%si)
     9c4:	20 00                	and    %al,(%bx,%si)
     9c6:	30 00                	xor    %al,(%bx,%si)
     9c8:	30 00                	xor    %al,(%bx,%si)
     9ca:	30 00                	xor    %al,(%bx,%si)
     9cc:	fc                   	cld    
     9cd:	00 30                	add    %dh,(%bx,%si)
     9cf:	00 30                	add    %dh,(%bx,%si)
     9d1:	00 30                	add    %dh,(%bx,%si)
     9d3:	00 b0 01 e0          	add    %dh,-0x1fff(%bx,%si)
     9d7:	00 00                	add    %al,(%bx,%si)
     9d9:	00 00                	add    %al,(%bx,%si)
     9db:	00 00                	add    %al,(%bx,%si)
     9dd:	80 00 00             	addb   $0x0,(%bx,%si)
     9e0:	00 00                	add    %al,(%bx,%si)
     9e2:	00 00                	add    %al,(%bx,%si)
     9e4:	00 00                	add    %al,(%bx,%si)
     9e6:	30 00                	xor    %al,(%bx,%si)
     9e8:	30 00                	xor    %al,(%bx,%si)
     9ea:	00 00                	add    %al,(%bx,%si)
     9ec:	38 00                	cmp    %al,(%bx,%si)
     9ee:	30 00                	xor    %al,(%bx,%si)
     9f0:	30 00                	xor    %al,(%bx,%si)
     9f2:	30 00                	xor    %al,(%bx,%si)
     9f4:	30 00                	xor    %al,(%bx,%si)
     9f6:	78 00                	js     0x9f8
     9f8:	00 00                	add    %al,(%bx,%si)
     9fa:	00 00                	add    %al,(%bx,%si)
     9fc:	00 80 00 00          	add    %al,0x0(%bx,%si)
	...
     a0c:	f6 00 8c             	testb  $0x8c,(%bx,%si)
     a0f:	01 8c 01 8c          	add    %cx,-0x73ff(%si)
     a13:	01 8c 01 8c          	add    %cx,-0x73ff(%si)
     a17:	01 00                	add    %ax,(%bx,%si)
     a19:	00 00                	add    %al,(%bx,%si)
     a1b:	00 00                	add    %al,(%bx,%si)
     a1d:	80 00 00             	addb   $0x0,(%bx,%si)
	...
     a2c:	bc 01 c6             	mov    $0xc601,%sp
     a2f:	00 c6                	add    %al,%dh
     a31:	00 c6                	add    %al,%dh
     a33:	00 fc                	add    %bh,%ah
     a35:	00 c0                	add    %al,%al
     a37:	00 c6                	add    %al,%dh
     a39:	00 7c 00             	add    %bh,0x0(%si)
     a3c:	00 80 00 00          	add    %al,0x0(%bx,%si)
     a40:	00 00                	add    %al,(%bx,%si)
     a42:	80 03 70             	addb   $0x70,(%bp,%di)
     a45:	00 18                	add    %bl,(%bx,%si)
     a47:	02 04                	add    (%si),%al
     a49:	00 c4                	add    %al,%ah
     a4b:	00 82 01 0a          	add    %al,0xa01(%bp,%si)
     a4f:	03 0a                	add    (%bp,%si),%cx
     a51:	02 02                	add    (%bp,%si),%al
     a53:	00 04                	add    %al,(%si)
     a55:	00 04                	add    %al,(%si)
     a57:	00 18                	add    %bl,(%bx,%si)
     a59:	02 70 00             	add    0x0(%bx,%si),%dh
     a5c:	80 03 00             	addb   $0x0,(%bp,%di)
     a5f:	00 00                	add    %al,(%bx,%si)
     a61:	00 07                	add    %al,(%bx)
     a63:	00 38                	add    %bh,(%bx,%si)
     a65:	00 61 00             	add    %ah,0x0(%bx,%di)
     a68:	88 00                	mov    %al,(%bx,%si)
     a6a:	84 00                	test   %al,(%bx,%si)
     a6c:	02 01                	add    (%bx,%di),%al
     a6e:	41                   	inc    %cx
     a6f:	01 41 01             	add    %ax,0x1(%bx,%di)
     a72:	00 01                	add    %al,(%bx,%di)
     a74:	80 00 80             	addb   $0x80,(%bx,%si)
     a77:	00 61 00             	add    %ah,0x0(%bx,%di)
     a7a:	38 00                	cmp    %al,(%bx,%si)
     a7c:	07                   	pop    %es
     a7d:	00 00                	add    %al,(%bx,%si)
     a7f:	00 00                	add    %al,(%bx,%si)
     a81:	02 00                	add    (%bx,%si),%al
     a83:	03 80 03 c0          	add    -0x3ffd(%bx,%si),%ax
     a87:	03 e0                	add    %ax,%sp
     a89:	03 70 03             	add    0x3(%bx,%si),%si
     a8c:	38 03                	cmp    %al,(%bp,%di)
     a8e:	1c 03                	sbb    $0x3,%al
     a90:	00 03                	add    %al,(%bp,%di)
     a92:	00 03                	add    %al,(%bp,%di)
     a94:	00 03                	add    %al,(%bp,%di)
     a96:	00 03                	add    %al,(%bp,%di)
     a98:	00 03                	add    %al,(%bp,%di)
     a9a:	00 03                	add    %al,(%bp,%di)
     a9c:	00 03                	add    %al,(%bp,%di)
     a9e:	00 03                	add    %al,(%bp,%di)
     aa0:	01 00                	add    %ax,(%bx,%si)
     aa2:	03 00                	add    (%bx,%si),%ax
     aa4:	07                   	pop    %es
     aa5:	00 0f                	add    %cl,(%bx)
     aa7:	00 1f                	add    %bl,(%bx)
     aa9:	00 3b                	add    %bh,(%bp,%di)
     aab:	00 73 00             	add    %dh,0x0(%bp,%di)
     aae:	e3 00                	jcxz   0xab0
     ab0:	03 00                	add    (%bx,%si),%ax
     ab2:	03 00                	add    (%bx,%si),%ax
     ab4:	03 00                	add    (%bx,%si),%ax
     ab6:	03 00                	add    (%bx,%si),%ax
     ab8:	03 00                	add    (%bx,%si),%ax
     aba:	03 00                	add    (%bx,%si),%ax
     abc:	03 00                	add    (%bx,%si),%ax
     abe:	03 00                	add    (%bx,%si),%ax
     ac0:	00 00                	add    %al,(%bx,%si)
     ac2:	80 03 f0             	addb   $0xf0,(%bp,%di)
     ac5:	03 fc                	add    %sp,%di
     ac7:	03 fa                	add    %dx,%di
     ac9:	03 f2                	add    %dx,%si
     acb:	03 82 03 02          	add    0x203(%bp,%si),%ax
     acf:	00 02                	add    %al,(%bp,%si)
     ad1:	00 02                	add    %al,(%bp,%si)
     ad3:	00 02                	add    %al,(%bp,%si)
     ad5:	00 02                	add    %al,(%bp,%si)
     ad7:	00 0c                	add    %cl,(%si)
     ad9:	00 70 00             	add    %dh,0x0(%bx,%si)
     adc:	80 03 00             	addb   $0x0,(%bp,%di)
     adf:	00 00                	add    %al,(%bx,%si)
     ae1:	00 07                	add    %al,(%bx)
     ae3:	00 3f                	add    %bh,(%bx)
     ae5:	00 ff                	add    %bh,%bh
     ae7:	00 7f 01             	add    %bh,0x1(%bx)
     aea:	3f                   	aas    
     aeb:	01 07                	add    %ax,(%bx)
     aed:	01 00                	add    %ax,(%bx,%si)
     aef:	01 00                	add    %ax,(%bx,%si)
     af1:	01 00                	add    %ax,(%bx,%si)
     af3:	01 00                	add    %ax,(%bx,%si)
     af5:	01 00                	add    %ax,(%bx,%si)
     af7:	01 c0                	add    %ax,%ax
     af9:	00 38                	add    %bh,(%bx,%si)
     afb:	00 07                	add    %al,(%bx)
     afd:	00 00                	add    %al,(%bx,%si)
     aff:	00 00                	add    %al,(%bx,%si)
     b01:	00 fc                	add    %bh,%ah
     b03:	00 86 01 06          	add    %al,0x601(%bp)
     b07:	01 06 00 06          	add    %ax,0x600
     b0b:	00 fc                	add    %bh,%ah
     b0d:	00 80 01 80          	add    %al,-0x7fff(%bx,%si)
     b11:	01 82 01 86          	add    %ax,-0x79ff(%bp,%si)
     b15:	01 fc                	add    %di,%sp
     b17:	00 00                	add    %al,(%bx,%si)
     b19:	00 00                	add    %al,(%bx,%si)
     b1b:	00 00                	add    %al,(%bx,%si)
     b1d:	80 00 00             	addb   $0x0,(%bx,%si)
	...
     b2c:	f6 00 9c             	testb  $0x9c,(%bx,%si)
     b2f:	01 0c                	add    %cx,(%si)
     b31:	00 0c                	add    %cl,(%si)
     b33:	00 0c                	add    %cl,(%si)
     b35:	00 1e 00 00          	add    %bl,0x0
     b39:	00 00                	add    %al,(%bx,%si)
     b3b:	00 00                	add    %al,(%bx,%si)
     b3d:	80 00 00             	addb   $0x0,(%bx,%si)
	...
     b4c:	f8                   	clc    
     b4d:	00 8c 01 8c          	add    %cl,-0x73ff(%si)
     b51:	01 8c 01 8c          	add    %cx,-0x73ff(%si)
     b55:	01 f8                	add    %di,%ax
     b57:	00 00                	add    %al,(%bx,%si)
     b59:	00 00                	add    %al,(%bx,%si)
     b5b:	00 00                	add    %al,(%bx,%si)
     b5d:	80 00 00             	addb   $0x0,(%bx,%si)
     b60:	00 00                	add    %al,(%bx,%si)
     b62:	fe 01                	incb   (%bx,%di)
     b64:	8c 01                	mov    %es,(%bx,%di)
     b66:	0c 01                	or     $0x1,%al
     b68:	0c 00                	or     $0x0,%al
     b6a:	4c                   	dec    %sp
     b6b:	00 7c 00             	add    %bh,0x0(%si)
     b6e:	4c                   	dec    %sp
     b6f:	00 0c                	add    %cl,(%si)
     b71:	00 0c                	add    %cl,(%si)
     b73:	01 8c 01 fe          	add    %cx,-0x1ff(%si)
     b77:	01 00                	add    %ax,(%bx,%si)
     b79:	00 00                	add    %al,(%bx,%si)
     b7b:	00 00                	add    %al,(%bx,%si)
     b7d:	80 00 00             	addb   $0x0,(%bx,%si)
     b80:	00 00                	add    %al,(%bx,%si)
     b82:	fc                   	cld    
     b83:	00 86 01 86          	add    %al,-0x79ff(%bp)
     b87:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     b8b:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     b8f:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     b93:	01 86 01 fc          	add    %ax,-0x3ff(%bp)
     b97:	00 00                	add    %al,(%bx,%si)
     b99:	00 00                	add    %al,(%bx,%si)
     b9b:	00 00                	add    %al,(%bx,%si)
     b9d:	80 00 00             	addb   $0x0,(%bx,%si)
     ba0:	00 00                	add    %al,(%bx,%si)
     ba2:	8e 01                	mov    (%bx,%di),%es
     ba4:	8c 01                	mov    %es,(%bx,%di)
     ba6:	cc                   	int3   
     ba7:	00 6c 00             	add    %ch,0x0(%si)
     baa:	3c 00                	cmp    $0x0,%al
     bac:	1c 00                	sbb    $0x0,%al
     bae:	3c 00                	cmp    $0x0,%al
     bb0:	6c                   	insb   (%dx),%es:(%di)
     bb1:	00 cc                	add    %cl,%ah
     bb3:	00 8c 01 8e          	add    %cl,-0x71ff(%si)
     bb7:	01 00                	add    %ax,(%bx,%si)
     bb9:	00 00                	add    %al,(%bx,%si)
     bbb:	00 00                	add    %al,(%bx,%si)
     bbd:	80 00 00             	addb   $0x0,(%bx,%si)
     bc0:	00 00                	add    %al,(%bx,%si)
     bc2:	fe 00                	incb   (%bx,%si)
     bc4:	8c 01                	mov    %es,(%bx,%di)
     bc6:	8c 01                	mov    %es,(%bx,%di)
     bc8:	8c 01                	mov    %es,(%bx,%di)
     bca:	8c 01                	mov    %es,(%bx,%di)
     bcc:	fc                   	cld    
     bcd:	00 6c 00             	add    %ch,0x0(%si)
     bd0:	cc                   	int3   
     bd1:	00 8c 01 8c          	add    %cl,-0x73ff(%si)
     bd5:	01 8e 01 00          	add    %cx,0x1(%bp)
     bd9:	00 00                	add    %al,(%bx,%si)
     bdb:	00 00                	add    %al,(%bx,%si)
     bdd:	80 00 00             	addb   $0x0,(%bx,%si)
     be0:	00 00                	add    %al,(%bx,%si)
     be2:	86 01                	xchg   %al,(%bx,%di)
     be4:	ce                   	into   
     be5:	01 fe                	add    %di,%si
     be7:	01 b6 01 86          	add    %si,-0x79ff(%bp)
     beb:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     bef:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     bf3:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     bf7:	01 00                	add    %ax,(%bx,%si)
     bf9:	00 00                	add    %al,(%bx,%si)
     bfb:	00 00                	add    %al,(%bx,%si)
     bfd:	80 00 00             	addb   $0x0,(%bx,%si)
	...
     c20:	00 03                	add    %al,(%bp,%di)
     c22:	c0 03 f0             	rolb   $0xf0,(%bp,%di)
     c25:	01 f8                	add    %di,%ax
     c27:	00 f8                	add    %bh,%al
     c29:	00 70 00             	add    %dh,0x0(%bx,%si)
     c2c:	00 00                	add    %al,(%bx,%si)
     c2e:	00 00                	add    %al,(%bx,%si)
     c30:	00 00                	add    %al,(%bx,%si)
     c32:	00 03                	add    %al,(%bp,%di)
     c34:	c0 01 e0             	rolb   $0xe0,(%bx,%di)
     c37:	00 70 00             	add    %dh,0x0(%bx,%si)
     c3a:	78 00                	js     0xc3c
     c3c:	78 00                	js     0xc3e
     c3e:	f8                   	clc    
     c3f:	00 1f                	add    %bl,(%bx)
     c41:	00 ff                	add    %bh,%bh
     c43:	00 f0                	add    %dh,%al
     c45:	01 e0                	add    %sp,%ax
     c47:	01 c0                	add    %ax,%ax
     c49:	03 c0                	add    %ax,%ax
     c4b:	03 c0                	add    %ax,%ax
     c4d:	03 f0                	add    %ax,%si
     c4f:	03 ce                	add    %si,%cx
     c51:	03 c1                	add    %cx,%ax
     c53:	03 c0                	add    %ax,%ax
     c55:	03 c0                	add    %ax,%ax
     c57:	03 c0                	add    %ax,%ax
     c59:	03 c0                	add    %ax,%ax
     c5b:	03 c0                	add    %ax,%ax
     c5d:	03 e0                	add    %ax,%sp
     c5f:	03 80 01 e0          	add    -0x1fff(%bx,%si),%ax
     c63:	01 fc                	add    %di,%sp
     c65:	01 e0                	add    %sp,%ax
     c67:	01 e0                	add    %sp,%ax
     c69:	03 e0                	add    %ax,%sp
     c6b:	03 e0                	add    %ax,%sp
     c6d:	01 e0                	add    %sp,%ax
     c6f:	01 e0                	add    %sp,%ax
     c71:	01 e0                	add    %sp,%ax
     c73:	01 e0                	add    %sp,%ax
     c75:	01 e0                	add    %sp,%ax
     c77:	01 e0                	add    %sp,%ax
     c79:	01 e0                	add    %sp,%ax
     c7b:	01 e0                	add    %sp,%ax
     c7d:	01 e0                	add    %sp,%ax
     c7f:	01 f0                	add    %si,%ax
     c81:	03 fc                	add    %sp,%di
     c83:	03 fe                	add    %si,%di
     c85:	03 03                	add    (%bp,%di),%ax
     c87:	03 01                	add    (%bx,%di),%ax
     c89:	02 00                	add    (%bx,%si),%al
	...
     c9f:	00 00                	add    %al,(%bx,%si)
     ca1:	00 03                	add    %al,(%bp,%di)
     ca3:	03 e7                	add    %di,%sp
     ca5:	03 0f                	add    (%bx),%cx
     ca7:	03 1f                	add    (%bx),%bx
     ca9:	03 1f                	add    (%bx),%bx
     cab:	03 3e 03 3e          	add    0x3e03,%di
     caf:	03 3e 03 3e          	add    0x3e03,%di
     cb3:	03 3e 03 3e          	add    0x3e03,%di
     cb7:	03 1e 03 1e          	add    0x1e03,%bx
     cbb:	03 0f                	add    (%bx),%cx
     cbd:	03 07                	add    (%bx),%ax
     cbf:	03 c3                	add    %bx,%ax
     cc1:	03 f3                	add    %bx,%si
     cc3:	03 fb                	add    %bx,%di
     cc5:	03 8f 03 07          	add    0x703(%bx),%cx
     cc9:	00 03                	add    %al,(%bp,%di)
     ccb:	00 03                	add    %al,(%bp,%di)
     ccd:	00 03                	add    %al,(%bp,%di)
     ccf:	00 03                	add    %al,(%bp,%di)
     cd1:	00 03                	add    %al,(%bp,%di)
     cd3:	00 03                	add    %al,(%bp,%di)
     cd5:	00 03                	add    %al,(%bp,%di)
     cd7:	00 03                	add    %al,(%bp,%di)
     cd9:	00 03                	add    %al,(%bp,%di)
     cdb:	00 03                	add    %al,(%bp,%di)
     cdd:	00 03                	add    %al,(%bp,%di)
     cdf:	00 80 01 e1          	add    %al,-0x1eff(%bx,%si)
     ce3:	01 fd                	add    %di,%bp
     ce5:	01 e0                	add    %sp,%ax
     ce7:	01 e0                	add    %sp,%ax
     ce9:	01 e0                	add    %sp,%ax
     ceb:	01 e0                	add    %sp,%ax
     ced:	01 e0                	add    %sp,%ax
     cef:	01 e0                	add    %sp,%ax
     cf1:	01 e0                	add    %sp,%ax
     cf3:	01 e0                	add    %sp,%ax
     cf5:	01 e0                	add    %sp,%ax
     cf7:	01 e0                	add    %sp,%ax
     cf9:	01 e0                	add    %sp,%ax
     cfb:	01 e0                	add    %sp,%ax
     cfd:	01 e0                	add    %sp,%ax
     cff:	01 00                	add    %ax,(%bx,%si)
     d01:	03 c0                	add    %ax,%ax
     d03:	03 f0                	add    %ax,%si
     d05:	00 78 00             	add    %bh,0x0(%bx,%si)
     d08:	3c 00                	cmp    $0x0,%al
     d0a:	1c 00                	sbb    $0x0,%al
     d0c:	1e                   	push   %ds
     d0d:	00 1e 00 1e          	add    %bl,0x1e00
     d11:	00 1e 00 1e          	add    %bl,0x1e00
     d15:	00 1e 00 1e          	add    %bl,0x1e00
     d19:	00 3e 00 3c          	add    %bh,0x3c00
     d1d:	00 fc                	add    %bh,%ah
     d1f:	00 1f                	add    %bl,(%bx)
     d21:	00 ff                	add    %bh,%bh
     d23:	00 f0                	add    %dh,%al
     d25:	01 e0                	add    %sp,%ax
     d27:	03 e0                	add    %ax,%sp
     d29:	03 c0                	add    %ax,%ax
     d2b:	01 00                	add    %ax,(%bx,%si)
	...
     d39:	02 00                	add    (%bx,%si),%al
     d3b:	03 00                	add    (%bx,%si),%ax
     d3d:	03 c0                	add    %ax,%ax
     d3f:	01 00                	add    %ax,(%bx,%si)
     d41:	03 c0                	add    %ax,%ax
     d43:	03 f0                	add    %ax,%si
     d45:	00 78 00             	add    %bh,0x0(%bx,%si)
     d48:	3c 00                	cmp    $0x0,%al
     d4a:	1c 00                	sbb    $0x0,%al
     d4c:	1e                   	push   %ds
     d4d:	00 1e 00 1e          	add    %bl,0x1e00
     d51:	00 1e 00 1e          	add    %bl,0x1e00
     d55:	00 1e 00 1e          	add    %bl,0x1e00
     d59:	00 3c                	add    %bh,(%si)
     d5b:	00 7c 00             	add    %bh,0x0(%si)
     d5e:	f8                   	clc    
     d5f:	00 3f                	add    %bh,(%bx)
     d61:	00 ff                	add    %bh,%bh
     d63:	01 c0                	add    %ax,%ax
     d65:	03 80 03 00          	add    0x3(%bx,%si),%ax
     d69:	03 00                	add    (%bx,%si),%ax
     d6b:	02 00                	add    (%bx,%si),%al
     d6d:	02 00                	add    (%bx,%si),%al
	...
     d7f:	02 f0                	add    %al,%dh
     d81:	03 f8                	add    %ax,%di
     d83:	03 c1                	add    %cx,%ax
     d85:	03 c3                	add    %bx,%ax
     d87:	03 c7                	add    %di,%ax
     d89:	03 c7                	add    %di,%ax
     d8b:	03 cf                	add    %di,%cx
     d8d:	03 cf                	add    %di,%cx
     d8f:	03 cf                	add    %di,%cx
     d91:	03 cf                	add    %di,%cx
     d93:	03 cf                	add    %di,%cx
     d95:	03 cf                	add    %di,%cx
     d97:	03 cf                	add    %di,%cx
     d99:	03 c7                	add    %di,%ax
     d9b:	03 c7                	add    %di,%ax
     d9d:	03 c3                	add    %bx,%ax
     d9f:	03 1f                	add    (%bx),%bx
     da1:	00 1f                	add    %bl,(%bx)
	...
     dd3:	00 e0                	add    %ah,%al
     dd5:	00 f0                	add    %dh,%al
     dd7:	01 f0                	add    %si,%ax
     dd9:	01 e0                	add    %sp,%ax
	...
     df7:	02 00                	add    (%bx,%si),%al
     df9:	02 00                	add    (%bx,%si),%al
     dfb:	03 80 03 c0          	add    -0x3ffd(%bx,%si),%ax
     dff:	03 00                	add    (%bx,%si),%ax
	...
     e1d:	00 00                	add    %al,(%bx,%si)
     e1f:	00 f0                	add    %dh,%al
     e21:	01 f0                	add    %si,%ax
     e23:	03 c0                	add    %ax,%ax
     e25:	03 00                	add    (%bx,%si),%ax
	...
     e3f:	00 d0                	add    %dl,%al
     e41:	03 cf                	add    %di,%cx
     e43:	03 83 03 00          	add    0x3(%bp,%di),%ax
	...
     e5f:	00 e6                	add    %ah,%dh
     e61:	03 e7                	add    %di,%sp
     e63:	03 e3                	add    %bx,%sp
     e65:	01 e0                	add    %sp,%ax
     e67:	01 e0                	add    %sp,%ax
     e69:	01 e0                	add    %sp,%ax
     e6b:	01 e0                	add    %sp,%ax
     e6d:	01 e0                	add    %sp,%ax
     e6f:	01 f0                	add    %si,%ax
     e71:	03 fc                	add    %sp,%di
     e73:	03 00                	add    (%bx,%si),%ax
	...
     e81:	02 83 03 fe          	add    -0x1fd(%bp,%di),%al
	...
     e91:	00 03                	add    %al,(%bp,%di)
	...
     e9f:	00 03                	add    %al,(%bp,%di)
     ea1:	03 81 03 e0          	add    -0x1ffd(%bx,%di),%ax
     ea5:	03 00                	add    (%bx,%si),%ax
	...
     ebf:	00 03                	add    %al,(%bp,%di)
     ec1:	00 07                	add    %al,(%bx)
     ec3:	00 1f                	add    %bl,(%bx)
	...
     edd:	00 00                	add    %al,(%bx,%si)
     edf:	00 e0                	add    %ah,%al
     ee1:	01 f0                	add    %si,%ax
     ee3:	03 fc                	add    %sp,%di
     ee5:	03 00                	add    (%bx,%si),%ax
	...
     eff:	00 f8                	add    %bh,%al
     f01:	03 e0                	add    %ax,%sp
     f03:	03 83 03 00          	add    0x3(%bp,%di),%ax
	...
     f1f:	00 ff                	add    %bh,%bh
     f21:	00 7f 00             	add    %bh,0x0(%bx)
     f24:	0f 00 00             	sldt   (%bx,%si)
	...
     f3f:	00 f0                	add    %dh,%al
     f41:	01 c0                	add    %ax,%ax
     f43:	03 00                	add    (%bx,%si),%ax
     f45:	03 00                	add    (%bx,%si),%ax
	...
     f5f:	00 00                	add    %al,(%bx,%si)
     f61:	03 c1                	add    %cx,%ax
     f63:	03 7f 00             	add    0x0(%bx),%di
	...
     f7e:	00 00                	add    %al,(%bx,%si)
     f80:	c1 03 80             	rolw   $0x80,(%bp,%di)
     f83:	03 00                	add    (%bx,%si),%ax
     f85:	03 00                	add    (%bx,%si),%ax
	...
     f9f:	00 41 00             	add    %al,0x0(%bx,%di)
     fa2:	3f                   	aas    
     fa3:	00 0f                	add    %cl,(%bx)
	...
     fc1:	00 78 00             	add    %bh,0x0(%bx,%si)
     fc4:	cc                   	int3   
     fc5:	00 86 01 86          	add    %al,-0x79ff(%bp)
     fc9:	01 86 01 fe          	add    %ax,-0x1ff(%bp)
     fcd:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     fd1:	01 86 01 86          	add    %ax,-0x79ff(%bp)
     fd5:	01 86 01 00          	add    %ax,0x1(%bp)
     fd9:	00 00                	add    %al,(%bx,%si)
     fdb:	00 00                	add    %al,(%bx,%si)
     fdd:	80 00 00             	addb   $0x0,(%bx,%si)
     fe0:	00 00                	add    %al,(%bx,%si)
     fe2:	fe 00                	incb   (%bx,%si)
     fe4:	8c 01                	mov    %es,(%bx,%di)
     fe6:	8c 01                	mov    %es,(%bx,%di)
     fe8:	8c 01                	mov    %es,(%bx,%di)
     fea:	8c 01                	mov    %es,(%bx,%di)
     fec:	fc                   	cld    
     fed:	00 8c 01 8c          	add    %cl,-0x73ff(%si)
     ff1:	01 8c 01 8c          	add    %cx,-0x73ff(%si)
     ff5:	01 fe                	add    %di,%si
     ff7:	00 00                	add    %al,(%bx,%si)
     ff9:	00 00                	add    %al,(%bx,%si)
     ffb:	00 00                	add    %al,(%bx,%si)
     ffd:	80 00 00             	addb   $0x0,(%bx,%si)
	...
    100c:	8c 01                	mov    %es,(%bx,%di)
    100e:	8c 01                	mov    %es,(%bx,%di)
    1010:	8c 01                	mov    %es,(%bx,%di)
    1012:	8c 01                	mov    %es,(%bx,%di)
    1014:	f8                   	clc    
    1015:	01 80 01 8c          	add    %ax,-0x73ff(%bx,%si)
    1019:	01 f8                	add    %di,%ax
    101b:	00 00                	add    %al,(%bx,%si)
    101d:	80 00 00             	addb   $0x0,(%bx,%si)
	...
    102c:	db 00                	fildl  (%bx,%si)
    102e:	fe 01                	incb   (%bx,%di)
    1030:	b6 01                	mov    $0x1,%dh
    1032:	b6 01                	mov    $0x1,%dh
    1034:	b6 01                	mov    $0x1,%dh
    1036:	b6 01                	mov    $0x1,%dh
    1038:	00 00                	add    %al,(%bx,%si)
    103a:	00 00                	add    %al,(%bx,%si)
    103c:	00 80 00 00          	add    %al,0x0(%bx,%si)
    1040:	fe 03                	incb   (%bp,%di)
    1042:	83 03 83             	addw   $0xff83,(%bp,%di)
    1045:	03 83 03 83          	add    -0x7cfd(%bp,%di),%ax
    1049:	03 83 03 83          	add    -0x7cfd(%bp,%di),%ax
    104d:	03 83 03 83          	add    -0x7cfd(%bp,%di),%ax
    1051:	03 83 03 03          	add    0x303(%bp,%di),%ax
    1055:	03 03                	add    (%bp,%di),%ax
    1057:	00 03                	add    %al,(%bp,%di)
    1059:	00 03                	add    %al,(%bp,%di)
    105b:	00 03                	add    %al,(%bp,%di)
    105d:	00 03                	add    %al,(%bp,%di)
    105f:	00 ff                	add    %bh,%bh
    1061:	03 9f 03 0f          	add    0xf03(%bx),%bx
    1065:	03 0f                	add    (%bx),%cx
    1067:	03 0f                	add    (%bx),%cx
    1069:	03 0f                	add    (%bx),%cx
    106b:	03 0f                	add    (%bx),%cx
    106d:	03 0f                	add    (%bx),%cx
    106f:	03 0f                	add    (%bx),%cx
    1071:	03 9f 03 ff          	add    -0xfd(%bx),%bx
    1075:	03 00                	add    (%bx,%si),%ax
	...
    107f:	00 7f 00             	add    %bh,0x0(%bx)
    1082:	c7 00 87 01          	movw   $0x187,(%bx,%si)
    1086:	07                   	pop    %es
    1087:	03 07                	add    (%bx),%ax
    1089:	03 07                	add    (%bx),%ax
    108b:	03 07                	add    (%bx),%ax
    108d:	03 07                	add    (%bx),%ax
    108f:	03 07                	add    (%bx),%ax
    1091:	03 07                	add    (%bx),%ax
    1093:	03 03                	add    (%bp,%di),%ax
    1095:	03 00                	add    (%bx,%si),%ax
    1097:	03 00                	add    (%bx,%si),%ax
    1099:	03 00                	add    (%bx,%si),%ax
    109b:	03 00                	add    (%bx,%si),%ax
    109d:	03 00                	add    (%bx,%si),%ax
    109f:	03 03                	add    (%bp,%di),%ax
    10a1:	00 03                	add    %al,(%bp,%di)
    10a3:	00 03                	add    %al,(%bp,%di)
    10a5:	00 03                	add    %al,(%bp,%di)
    10a7:	00 03                	add    %al,(%bp,%di)
    10a9:	00 03                	add    %al,(%bp,%di)
    10ab:	00 03                	add    %al,(%bp,%di)
    10ad:	00 fe                	add    %bh,%dh
    10af:	03 00                	add    (%bx,%si),%ax
	...
    10cd:	00 ff                	add    %bh,%bh
    10cf:	03 00                	add    (%bx,%si),%ax
	...
    10e1:	03 00                	add    (%bx,%si),%ax
    10e3:	03 00                	add    (%bx,%si),%ax
    10e5:	03 00                	add    (%bx,%si),%ax
    10e7:	03 00                	add    (%bx,%si),%ax
    10e9:	03 00                	add    (%bx,%si),%ax
    10eb:	03 00                	add    (%bx,%si),%ax
    10ed:	03 ff                	add    %di,%di
    10ef:	01 00                	add    %ax,(%bx,%si)
	...
    10fd:	00 00                	add    %al,(%bx,%si)
    10ff:	00 b8 00 3e          	add    %bh,0x3e00(%bx,%si)
    1103:	8e d8                	mov    %ax,%ds
    1105:	8e d0                	mov    %ax,%ss
    1107:	bc ff 1f             	mov    $0x1fff,%sp
    110a:	81 e4 fe ff          	and    $0xfffe,%sp
    110e:	be 00 18             	mov    $0x1800,%si
    1111:	8b c6                	mov    %si,%ax
    1113:	05 04 00             	add    $0x4,%ax
    1116:	89 04                	mov    %ax,(%si)
    1118:	c7 44 02 ff ff       	movw   $0xffff,0x2(%si)
    111d:	c7 06 d0 02 00 00    	movw   $0x0,0x2d0
    1123:	8c d8                	mov    %ds,%ax
    1125:	8e c0                	mov    %ax,%es
    1127:	bd 00 00             	mov    $0x0,%bp
    112a:	ea 97 01 10 fd       	ljmp   $0xfd10,$0x197
    112f:	ff 55 8b             	call   *-0x75(%di)
    1132:	ec                   	in     (%dx),%al
    1133:	2b 26 12 10          	sub    0x1012,%sp
    1137:	a0 4d 10             	mov    0x104d,%al
    113a:	a2 8d 00             	mov    %al,0x8d
    113d:	c7 06 88 00 76 02    	movw   $0x276,0x88
    1143:	ff 76 04             	push   0x4(%bp)
    1146:	b8 00 00             	mov    $0x0,%ax
    1149:	50                   	push   %ax
    114a:	b8 01 00             	mov    $0x1,%ax
    114d:	50                   	push   %ax
    114e:	ff 36 96 10          	push   0x1096
    1152:	ff 36 94 10          	push   0x1094
    1156:	e8 be 0a             	call   0x1c17
    1159:	89 46 fe             	mov    %ax,-0x2(%bp)
    115c:	83 7e fe 00          	cmpw   $0x0,-0x2(%bp)
    1160:	75 61                	jne    0x11c3
    1162:	ff 76 04             	push   0x4(%bp)
    1165:	e8 ce 04             	call   0x1636
    1168:	e8 0e 04             	call   0x1579
    116b:	80 3e 3b 00 01       	cmpb   $0x1,0x3b
    1170:	75 43                	jne    0x11b5
    1172:	a0 4d 10             	mov    0x104d,%al
    1175:	3a 06 8d 00          	cmp    0x8d,%al
    1179:	72 3a                	jb     0x11b5
    117b:	c6 06 08 00 00       	movb   $0x0,0x8
    1180:	e8 9f 04             	call   0x1622
    1183:	ff 76 04             	push   0x4(%bp)
    1186:	ff 36 4a 00          	push   0x4a
    118a:	ff 36 4e 00          	push   0x4e
    118e:	ff 36 52 00          	push   0x52
    1192:	ff 36 50 00          	push   0x50
    1196:	e8 7e 0a             	call   0x1c17
    1199:	89 46 fe             	mov    %ax,-0x2(%bp)
    119c:	83 7e fe 00          	cmpw   $0x0,-0x2(%bp)
    11a0:	75 08                	jne    0x11aa
    11a2:	ff 76 04             	push   0x4(%bp)
    11a5:	e8 82 01             	call   0x132a
    11a8:	eb 09                	jmp    0x11b3
    11aa:	ff 76 fe             	push   -0x2(%bp)
    11ad:	e8 a8 04             	call   0x1658
    11b0:	e8 44 04             	call   0x15f7
    11b3:	eb 0c                	jmp    0x11c1
    11b5:	b8 63 00             	mov    $0x63,%ax
    11b8:	50                   	push   %ax
    11b9:	e8 9c 04             	call   0x1658
    11bc:	c7 46 fe 0b 80       	movw   $0x800b,-0x2(%bp)
    11c1:	eb 0d                	jmp    0x11d0
    11c3:	81 7e fe 02 80       	cmpw   $0x8002,-0x2(%bp)
    11c8:	74 06                	je     0x11d0
    11ca:	ff 76 fe             	push   -0x2(%bp)
    11cd:	e8 88 04             	call   0x1658
    11d0:	81 7e fe 02 80       	cmpw   $0x8002,-0x2(%bp)
    11d5:	74 1a                	je     0x11f1
    11d7:	ff 76 04             	push   0x4(%bp)
    11da:	e8 29 0c             	call   0x1e06
    11dd:	83 7e 04 00          	cmpw   $0x0,0x4(%bp)
    11e1:	75 08                	jne    0x11eb
    11e3:	c7 06 04 00 c8 00    	movw   $0xc8,0x4
    11e9:	eb 06                	jmp    0x11f1
    11eb:	c7 06 06 00 c8 00    	movw   $0xc8,0x6
    11f1:	c6 06 08 00 01       	movb   $0x1,0x8
    11f6:	8b e5                	mov    %bp,%sp
    11f8:	5d                   	pop    %bp
    11f9:	c2 02 00             	ret    $0x2
    11fc:	55                   	push   %bp
    11fd:	8b ec                	mov    %sp,%bp
    11ff:	2b 26 14 10          	sub    0x1014,%sp
    1203:	ff 76 04             	push   0x4(%bp)
    1206:	b8 00 00             	mov    $0x0,%ax
    1209:	50                   	push   %ax
    120a:	b8 01 00             	mov    $0x1,%ax
    120d:	50                   	push   %ax
    120e:	ff 36 96 10          	push   0x1096
    1212:	ff 36 94 10          	push   0x1094
    1216:	e8 b3 04             	call   0x16cc
    1219:	89 46 fe             	mov    %ax,-0x2(%bp)
    121c:	83 7e fe 00          	cmpw   $0x0,-0x2(%bp)
    1220:	75 57                	jne    0x1279
    1222:	80 3e 3b 00 01       	cmpb   $0x1,0x3b
    1227:	75 47                	jne    0x1270
    1229:	ff 76 04             	push   0x4(%bp)
    122c:	e8 07 04             	call   0x1636
    122f:	c6 06 08 00 00       	movb   $0x0,0x8
    1234:	e8 eb 03             	call   0x1622
    1237:	e8 4a 03             	call   0x1584
    123a:	ff 76 04             	push   0x4(%bp)
    123d:	ff 36 4a 00          	push   0x4a
    1241:	ff 36 4e 00          	push   0x4e
    1245:	ff 36 52 00          	push   0x52
    1249:	ff 36 50 00          	push   0x50
    124d:	e8 7c 04             	call   0x16cc
    1250:	89 46 fe             	mov    %ax,-0x2(%bp)
    1253:	83 7e fe 00          	cmpw   $0x0,-0x2(%bp)
    1257:	75 0c                	jne    0x1265
    1259:	8b 46 04             	mov    0x4(%bp),%ax
    125c:	05 02 00             	add    $0x2,%ax
    125f:	50                   	push   %ax
    1260:	e8 c7 00             	call   0x132a
    1263:	eb 09                	jmp    0x126e
    1265:	ff 76 fe             	push   -0x2(%bp)
    1268:	e8 ed 03             	call   0x1658
    126b:	e8 89 03             	call   0x15f7
    126e:	eb 07                	jmp    0x1277
    1270:	b8 63 00             	mov    $0x63,%ax
    1273:	50                   	push   %ax
    1274:	e8 e1 03             	call   0x1658
    1277:	eb 0d                	jmp    0x1286
    1279:	81 7e fe 02 80       	cmpw   $0x8002,-0x2(%bp)
    127e:	74 06                	je     0x1286
    1280:	ff 76 fe             	push   -0x2(%bp)
    1283:	e8 d2 03             	call   0x1658
    1286:	c7 06 02 00 64 00    	movw   $0x64,0x2
    128c:	c6 06 08 00 01       	movb   $0x1,0x8
    1291:	8b e5                	mov    %bp,%sp
    1293:	5d                   	pop    %bp
    1294:	c2 02 00             	ret    $0x2
    1297:	8b ec                	mov    %sp,%bp
    1299:	2b 26 10 10          	sub    0x1010,%sp
    129d:	e8 08 01             	call   0x13a8
    12a0:	b0 13                	mov    $0x13,%al
    12a2:	e6 4a                	out    %al,$0x4a
    12a4:	e8 a6 00             	call   0x134d
    12a7:	a2 0a 00             	mov    %al,0xa
    12aa:	e8 9f 01             	call   0x144c
    12ad:	c6 06 08 00 01       	movb   $0x1,0x8
    12b2:	c6 06 09 00 01       	movb   $0x1,0x9
    12b7:	e8 3d 03             	call   0x15f7
    12ba:	e8 50 08             	call   0x1b0d
    12bd:	e8 d9 04             	call   0x1799
    12c0:	e8 50 0c             	call   0x1f13
    12c3:	c7 06 04 00 00 00    	movw   $0x0,0x4
    12c9:	c7 06 06 00 00 00    	movw   $0x0,0x6
    12cf:	c7 06 02 00 fa 00    	movw   $0xfa,0x2
    12d5:	c7 06 00 00 19 00    	movw   $0x19,0x0
    12db:	83 3e 04 00 00       	cmpw   $0x0,0x4
    12e0:	75 07                	jne    0x12e9
    12e2:	b8 00 00             	mov    $0x0,%ax
    12e5:	50                   	push   %ax
    12e6:	e8 47 fe             	call   0x1130
    12e9:	80 3e 4e 10 02       	cmpb   $0x2,0x104e
    12ee:	75 0e                	jne    0x12fe
    12f0:	83 3e 06 00 00       	cmpw   $0x0,0x6
    12f5:	75 07                	jne    0x12fe
    12f7:	b8 01 00             	mov    $0x1,%ax
    12fa:	50                   	push   %ax
    12fb:	e8 32 fe             	call   0x1130
    12fe:	80 3e 4f 10 00       	cmpb   $0x0,0x104f
    1303:	74 1c                	je     0x1321
    1305:	83 3e 02 00 00       	cmpw   $0x0,0x2
    130a:	75 15                	jne    0x1321
    130c:	b8 00 00             	mov    $0x0,%ax
    130f:	50                   	push   %ax
    1310:	e8 e9 fe             	call   0x11fc
    1313:	80 3e 4f 10 02       	cmpb   $0x2,0x104f
    1318:	75 07                	jne    0x1321
    131a:	b8 01 00             	mov    $0x1,%ax
    131d:	50                   	push   %ax
    131e:	e8 db fe             	call   0x11fc
    1321:	e8 ce 00             	call   0x13f2
    1324:	eb b5                	jmp    0x12db
    1326:	e8 b7 1e             	call   0x31e0
    1329:	ff                   	(bad)  
    132a:	fa                   	cli    
    132b:	b0 ff                	mov    $0xff,%al
    132d:	e6 02                	out    %al,$0x2
    132f:	58                   	pop    %ax
    1330:	58                   	pop    %ax
    1331:	a3 40 10             	mov    %ax,0x1040
    1334:	33 c0                	xor    %ax,%ax
    1336:	8e c0                	mov    %ax,%es
    1338:	bf 00 04             	mov    $0x400,%di
    133b:	be 38 10             	mov    $0x1038,%si
    133e:	b9 10 00             	mov    $0x10,%cx
    1341:	fc                   	cld    
    1342:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    1344:	a1 56 00             	mov    0x56,%ax
    1347:	50                   	push   %ax
    1348:	a1 54 00             	mov    0x54,%ax
    134b:	50                   	push   %ax
    134c:	cb                   	lret   
    134d:	06                   	push   %es
    134e:	33 c0                	xor    %ax,%ax
    1350:	8e c0                	mov    %ax,%es
    1352:	26 8b 1e 15 04       	mov    %es:0x415,%bx
    1357:	26 a1 20 04          	mov    %es:0x420,%ax
    135b:	f6 c4 80             	test   $0x80,%ah
    135e:	b8 00 00             	mov    $0x0,%ax
    1361:	75 05                	jne    0x1368
    1363:	89 1e 4d 10          	mov    %bx,0x104d
    1367:	40                   	inc    %ax
    1368:	07                   	pop    %es
    1369:	c3                   	ret    
    136a:	06                   	push   %es
    136b:	33 c0                	xor    %ax,%ax
    136d:	8e c0                	mov    %ax,%es
    136f:	26 a1 20 04          	mov    %es:0x420,%ax
    1373:	07                   	pop    %es
    1374:	f6 c4 40             	test   $0x40,%ah
    1377:	b8 00 00             	mov    $0x0,%ax
    137a:	74 01                	je     0x137d
    137c:	40                   	inc    %ax
    137d:	a3 4a 10             	mov    %ax,0x104a
    1380:	c3                   	ret    
    1381:	1e                   	push   %ds
    1382:	50                   	push   %ax
    1383:	b8 00 3e             	mov    $0x3e00,%ax
    1386:	8e d8                	mov    %ax,%ds
    1388:	a1 40 02             	mov    0x240,%ax
    138b:	23 c0                	and    %ax,%ax
    138d:	74 09                	je     0x1398
    138f:	55                   	push   %bp
    1390:	8b ec                	mov    %sp,%bp
    1392:	89 46 06             	mov    %ax,0x6(%bp)
    1395:	5d                   	pop    %bp
    1396:	eb 06                	jmp    0x139e
    1398:	e4 40                	in     $0x40,%al
    139a:	b0 20                	mov    $0x20,%al
    139c:	e6 00                	out    %al,$0x0
    139e:	58                   	pop    %ax
    139f:	1f                   	pop    %ds
    13a0:	cf                   	iret   
    13a1:	50                   	push   %ax
    13a2:	b0 20                	mov    $0x20,%al
    13a4:	e6 00                	out    %al,$0x0
    13a6:	58                   	pop    %ax
    13a7:	cf                   	iret   
    13a8:	06                   	push   %es
    13a9:	33 c0                	xor    %ax,%ax
    13ab:	8e c0                	mov    %ax,%es
    13ad:	bf 40 01             	mov    $0x140,%di
    13b0:	be 18 10             	mov    $0x1018,%si
    13b3:	b9 10 00             	mov    $0x10,%cx
    13b6:	fc                   	cld    
    13b7:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    13b9:	07                   	pop    %es
    13ba:	b0 ff                	mov    $0xff,%al
    13bc:	e6 02                	out    %al,$0x2
    13be:	fb                   	sti    
    13bf:	c3                   	ret    
    13c0:	33 c0                	xor    %ax,%ax
    13c2:	e6 66                	out    %al,$0x66
    13c4:	e4 66                	in     $0x66,%al
    13c6:	24 04                	and    $0x4,%al
    13c8:	74 f6                	je     0x13c0
    13ca:	8b dc                	mov    %sp,%bx
    13cc:	8b 47 02             	mov    0x2(%bx),%ax
    13cf:	e6 64                	out    %al,$0x64
    13d1:	c2 02 00             	ret    $0x2
    13d4:	8b dc                	mov    %sp,%bx
    13d6:	8b 47 02             	mov    0x2(%bx),%ax
    13d9:	3c 00                	cmp    $0x0,%al
    13db:	74 0a                	je     0x13e7
    13dd:	3c ff                	cmp    $0xff,%al
    13df:	74 0b                	je     0x13ec
    13e1:	50                   	push   %ax
    13e2:	e8 db ff             	call   0x13c0
    13e5:	eb 08                	jmp    0x13ef
    13e7:	e8 4f 00             	call   0x1439
    13ea:	eb 03                	jmp    0x13ef
    13ec:	e8 5d 00             	call   0x144c
    13ef:	c2 02 00             	ret    $0x2
    13f2:	33 c0                	xor    %ax,%ax
    13f4:	a2 08 00             	mov    %al,0x8
    13f7:	e6 66                	out    %al,$0x66
    13f9:	e4 66                	in     $0x66,%al
    13fb:	24 01                	and    $0x1,%al
    13fd:	74 27                	je     0x1426
    13ff:	e4 64                	in     $0x64,%al
    1401:	3c 04                	cmp    $0x4,%al
    1403:	75 21                	jne    0x1426
    1405:	50                   	push   %ax
    1406:	e8 4c 15             	call   0x2955
    1409:	80 3e 0f 00 00       	cmpb   $0x0,0xf
    140e:	74 16                	je     0x1426
    1410:	33 c0                	xor    %ax,%ax
    1412:	e6 66                	out    %al,$0x66
    1414:	e4 66                	in     $0x66,%al
    1416:	24 01                	and    $0x1,%al
    1418:	74 ef                	je     0x1409
    141a:	e4 64                	in     $0x64,%al
    141c:	3c 60                	cmp    $0x60,%al
    141e:	77 e9                	ja     0x1409
    1420:	50                   	push   %ax
    1421:	e8 31 15             	call   0x2955
    1424:	eb e3                	jmp    0x1409
    1426:	c6 06 08 00 01       	movb   $0x1,0x8
    142b:	c3                   	ret    
    142c:	fc                   	cld    
    142d:	ac                   	lods   %ds:(%si),%al
    142e:	56                   	push   %si
    142f:	51                   	push   %cx
    1430:	50                   	push   %ax
    1431:	e8 8c ff             	call   0x13c0
    1434:	59                   	pop    %cx
    1435:	5e                   	pop    %si
    1436:	e2 f4                	loop   0x142c
    1438:	c3                   	ret    
    1439:	8d 36 64 10          	lea    0x1064,%si
    143d:	b9 02 00             	mov    $0x2,%cx
    1440:	e8 e9 ff             	call   0x142c
    1443:	c6 06 0f 00 01       	movb   $0x1,0xf
    1448:	e8 60 01             	call   0x15ab
    144b:	c3                   	ret    
    144c:	8d 36 66 10          	lea    0x1066,%si
    1450:	b9 06 00             	mov    $0x6,%cx
    1453:	e8 d6 ff             	call   0x142c
    1456:	c6 06 0f 00 00       	movb   $0x0,0xf
    145b:	e8 01 00             	call   0x145f
    145e:	c3                   	ret    
    145f:	06                   	push   %es
    1460:	33 c0                	xor    %ax,%ax
    1462:	8e c0                	mov    %ax,%es
    1464:	26 a1 20 04          	mov    %es:0x420,%ax
    1468:	f6 c4 80             	test   $0x80,%ah
    146b:	74 3d                	je     0x14aa
    146d:	80 e4 7f             	and    $0x7f,%ah
    1470:	26 a3 20 04          	mov    %ax,%es:0x420
    1474:	bb 00 f0             	mov    $0xf000,%bx
    1477:	8e c3                	mov    %bx,%es
    1479:	25 ff 3f             	and    $0x3fff,%ax
    147c:	3d ff 3f             	cmp    $0x3fff,%ax
    147f:	75 0b                	jne    0x148c
    1481:	bf 54 0b             	mov    $0xb54,%di
    1484:	be 6c 10             	mov    $0x106c,%si
    1487:	e8 23 02             	call   0x16ad
    148a:	eb 1e                	jmp    0x14aa
    148c:	8b d8                	mov    %ax,%bx
    148e:	b8 40 03             	mov    $0x340,%ax
    1491:	bf 54 0b             	mov    $0xb54,%di
    1494:	b9 0a 00             	mov    $0xa,%cx
    1497:	fc                   	cld    
    1498:	f3 ab                	rep stos %ax,%es:(%di)
    149a:	b0 13                	mov    $0x13,%al
    149c:	fe c0                	inc    %al
    149e:	3c 22                	cmp    $0x22,%al
    14a0:	7d 08                	jge    0x14aa
    14a2:	d1 eb                	shr    %bx
    14a4:	72 f6                	jb     0x149c
    14a6:	50                   	push   %ax
    14a7:	e8 ae 01             	call   0x1658
    14aa:	8d 36 5f 10          	lea    0x105f,%si
    14ae:	b9 05 00             	mov    $0x5,%cx
    14b1:	e8 78 ff             	call   0x142c
    14b4:	ba 00 40             	mov    $0x4000,%dx
    14b7:	b8 b8 b4             	mov    $0xb4b8,%ax
    14ba:	8e c2                	mov    %dx,%es
    14bc:	26 a3 fe 03          	mov    %ax,%es:0x3fe
    14c0:	26 39 06 fe 03       	cmp    %ax,%es:0x3fe
    14c5:	75 18                	jne    0x14df
    14c7:	f7 d0                	not    %ax
    14c9:	26 a3 fe 03          	mov    %ax,%es:0x3fe
    14cd:	26 39 06 fe 03       	cmp    %ax,%es:0x3fe
    14d2:	75 0b                	jne    0x14df
    14d4:	f7 d0                	not    %ax
    14d6:	83 c2 40             	add    $0x40,%dx
    14d9:	81 fa 00 f0          	cmp    $0xf000,%dx
    14dd:	72 db                	jb     0x14ba
    14df:	89 16 3a 10          	mov    %dx,0x103a
    14e3:	b1 06                	mov    $0x6,%cl
    14e5:	d3 ea                	shr    %cl,%dx
    14e7:	8b c2                	mov    %dx,%ax
    14e9:	b1 64                	mov    $0x64,%cl
    14eb:	f6 f1                	div    %cl
    14ed:	8a d8                	mov    %al,%bl
    14ef:	f6 e1                	mul    %cl
    14f1:	2b d0                	sub    %ax,%dx
    14f3:	8b c2                	mov    %dx,%ax
    14f5:	b1 0a                	mov    $0xa,%cl
    14f7:	f6 f1                	div    %cl
    14f9:	93                   	xchg   %ax,%bx
    14fa:	50                   	push   %ax
    14fb:	53                   	push   %bx
    14fc:	04 30                	add    $0x30,%al
    14fe:	50                   	push   %ax
    14ff:	e8 be fe             	call   0x13c0
    1502:	58                   	pop    %ax
    1503:	50                   	push   %ax
    1504:	04 30                	add    $0x30,%al
    1506:	50                   	push   %ax
    1507:	e8 b6 fe             	call   0x13c0
    150a:	58                   	pop    %ax
    150b:	50                   	push   %ax
    150c:	8a c4                	mov    %ah,%al
    150e:	04 30                	add    $0x30,%al
    1510:	50                   	push   %ax
    1511:	e8 ac fe             	call   0x13c0
    1514:	b0 4b                	mov    $0x4b,%al
    1516:	50                   	push   %ax
    1517:	e8 a6 fe             	call   0x13c0
    151a:	5b                   	pop    %bx
    151b:	58                   	pop    %ax
    151c:	b9 00 f0             	mov    $0xf000,%cx
    151f:	8e c1                	mov    %cx,%es
    1521:	b9 41 03             	mov    $0x341,%cx
    1524:	32 e4                	xor    %ah,%ah
    1526:	03 c1                	add    %cx,%ax
    1528:	26 a3 9e 0c          	mov    %ax,%es:0xc9e
    152c:	8a c3                	mov    %bl,%al
    152e:	32 e4                	xor    %ah,%ah
    1530:	03 c1                	add    %cx,%ax
    1532:	26 a3 a0 0c          	mov    %ax,%es:0xca0
    1536:	8a c7                	mov    %bh,%al
    1538:	32 e4                	xor    %ah,%ah
    153a:	03 c1                	add    %cx,%ax
    153c:	26 a3 a2 0c          	mov    %ax,%es:0xca2
    1540:	b8 5d 03             	mov    $0x35d,%ax
    1543:	26 a3 a4 0c          	mov    %ax,%es:0xca4
    1547:	bf 94 0c             	mov    $0xc94,%di
    154a:	be 8c 10             	mov    $0x108c,%si
    154d:	e8 5d 01             	call   0x16ad
    1550:	e8 05 00             	call   0x1558
    1553:	e8 bf 00             	call   0x1615
    1556:	07                   	pop    %es
    1557:	c3                   	ret    
    1558:	b8 82 43             	mov    $0x4382,%ax
    155b:	26 a3 ce 0c          	mov    %ax,%es:0xcce
    155f:	40                   	inc    %ax
    1560:	26 a3 d0 0c          	mov    %ax,%es:0xcd0
    1564:	40                   	inc    %ax
    1565:	26 a3 d2 0c          	mov    %ax,%es:0xcd2
    1569:	40                   	inc    %ax
    156a:	26 a3 6e 0d          	mov    %ax,%es:0xd6e
    156e:	40                   	inc    %ax
    156f:	26 a3 70 0d          	mov    %ax,%es:0xd70
    1573:	40                   	inc    %ax
    1574:	26 a3 72 0d          	mov    %ax,%es:0xd72
    1578:	c3                   	ret    
    1579:	06                   	push   %es
    157a:	b8 00 f0             	mov    $0xf000,%ax
    157d:	8e c0                	mov    %ax,%es
    157f:	e8 d6 ff             	call   0x1558
    1582:	07                   	pop    %es
    1583:	c3                   	ret    
    1584:	06                   	push   %es
    1585:	b8 00 f0             	mov    $0xf000,%ax
    1588:	8e c0                	mov    %ax,%es
    158a:	b8 56 43             	mov    $0x4356,%ax
    158d:	26 a3 d0 0c          	mov    %ax,%es:0xcd0
    1591:	40                   	inc    %ax
    1592:	26 a3 d2 0c          	mov    %ax,%es:0xcd2
    1596:	b8 40 03             	mov    $0x340,%ax
    1599:	26 a3 ce 0c          	mov    %ax,%es:0xcce
    159d:	26 a3 6e 0d          	mov    %ax,%es:0xd6e
    15a1:	26 a3 70 0d          	mov    %ax,%es:0xd70
    15a5:	26 a3 72 0d          	mov    %ax,%es:0xd72
    15a9:	07                   	pop    %es
    15aa:	c3                   	ret    
    15ab:	e8 54 00             	call   0x1602
    15ae:	06                   	push   %es
    15af:	b8 00 f0             	mov    $0xf000,%ax
    15b2:	8e c0                	mov    %ax,%es
    15b4:	fc                   	cld    
    15b5:	b8 40 03             	mov    $0x340,%ax
    15b8:	bf 84 0c             	mov    $0xc84,%di
    15bb:	b9 4c 00             	mov    $0x4c,%cx
    15be:	f3 ab                	rep stos %ax,%es:(%di)
    15c0:	bf 24 0d             	mov    $0xd24,%di
    15c3:	b9 4c 00             	mov    $0x4c,%cx
    15c6:	f3 ab                	rep stos %ax,%es:(%di)
    15c8:	07                   	pop    %es
    15c9:	c3                   	ret    
    15ca:	80 3e 08 00 00       	cmpb   $0x0,0x8
    15cf:	74 25                	je     0x15f6
    15d1:	ff 0e 00 00          	decw   0x0
    15d5:	75 1f                	jne    0x15f6
    15d7:	80 3e 09 00 00       	cmpb   $0x0,0x9
    15dc:	74 0a                	je     0x15e8
    15de:	e8 21 00             	call   0x1602
    15e1:	c6 06 09 00 00       	movb   $0x0,0x9
    15e6:	eb 08                	jmp    0x15f0
    15e8:	e8 0c 00             	call   0x15f7
    15eb:	c6 06 09 00 01       	movb   $0x1,0x9
    15f0:	c7 06 00 00 19 00    	movw   $0x19,0x0
    15f6:	c3                   	ret    
    15f7:	06                   	push   %es
    15f8:	b8 00 f0             	mov    $0xf000,%ax
    15fb:	8e c0                	mov    %ax,%es
    15fd:	e8 15 00             	call   0x1615
    1600:	07                   	pop    %es
    1601:	c3                   	ret    
    1602:	06                   	push   %es
    1603:	b8 00 f0             	mov    $0xf000,%ax
    1606:	8e c0                	mov    %ax,%es
    1608:	b8 40 03             	mov    $0x340,%ax
    160b:	26 a3 90 0b          	mov    %ax,%es:0xb90
    160f:	26 a3 92 0b          	mov    %ax,%es:0xb92
    1613:	07                   	pop    %es
    1614:	c3                   	ret    
    1615:	b8 54 43             	mov    $0x4354,%ax
    1618:	26 a3 90 0b          	mov    %ax,%es:0xb90
    161c:	40                   	inc    %ax
    161d:	26 a3 92 0b          	mov    %ax,%es:0xb92
    1621:	c3                   	ret    
    1622:	06                   	push   %es
    1623:	b8 00 f0             	mov    $0xf000,%ax
    1626:	8e c0                	mov    %ax,%es
    1628:	b8 52 43             	mov    $0x4352,%ax
    162b:	26 a3 90 0b          	mov    %ax,%es:0xb90
    162f:	40                   	inc    %ax
    1630:	26 a3 92 0b          	mov    %ax,%es:0xb92
    1634:	07                   	pop    %es
    1635:	c3                   	ret    
    1636:	8b dc                	mov    %sp,%bx
    1638:	06                   	push   %es
    1639:	b8 00 f0             	mov    $0xf000,%ax
    163c:	8e c0                	mov    %ax,%es
    163e:	bf f4 0c             	mov    $0xcf4,%di
    1641:	b8 40 03             	mov    $0x340,%ax
    1644:	b9 0c 00             	mov    $0xc,%cx
    1647:	fc                   	cld    
    1648:	f3 ab                	rep stos %ax,%es:(%di)
    164a:	8b 47 02             	mov    0x2(%bx),%ax
    164d:	05 7e 43             	add    $0x437e,%ax
    1650:	26 a3 e8 0c          	mov    %ax,%es:0xce8
    1654:	07                   	pop    %es
    1655:	c2 02 00             	ret    $0x2
    1658:	8d 36 58 10          	lea    0x1058,%si
    165c:	b9 07 00             	mov    $0x7,%cx
    165f:	e8 ca fd             	call   0x142c
    1662:	8b dc                	mov    %sp,%bx
    1664:	06                   	push   %es
    1665:	b8 00 f0             	mov    $0xf000,%ax
    1668:	8e c0                	mov    %ax,%es
    166a:	bf f6 0c             	mov    $0xcf6,%di
    166d:	be 80 10             	mov    $0x1080,%si
    1670:	e8 3a 00             	call   0x16ad
    1673:	8b 47 02             	mov    0x2(%bx),%ax
    1676:	25 7f 00             	and    $0x7f,%ax
    1679:	3c 63                	cmp    $0x63,%al
    167b:	7f 2c                	jg     0x16a9
    167d:	b3 0a                	mov    $0xa,%bl
    167f:	f6 f3                	div    %bl
    1681:	50                   	push   %ax
    1682:	04 30                	add    $0x30,%al
    1684:	50                   	push   %ax
    1685:	e8 38 fd             	call   0x13c0
    1688:	58                   	pop    %ax
    1689:	50                   	push   %ax
    168a:	86 c4                	xchg   %al,%ah
    168c:	04 30                	add    $0x30,%al
    168e:	50                   	push   %ax
    168f:	e8 2e fd             	call   0x13c0
    1692:	58                   	pop    %ax
    1693:	8a dc                	mov    %ah,%bl
    1695:	32 e4                	xor    %ah,%ah
    1697:	8a fc                	mov    %ah,%bh
    1699:	05 41 43             	add    $0x4341,%ax
    169c:	26 a3 04 0d          	mov    %ax,%es:0xd04
    16a0:	81 c3 41 43          	add    $0x4341,%bx
    16a4:	26 89 1e 06 0d       	mov    %bx,%es:0xd06
    16a9:	07                   	pop    %es
    16aa:	c2 02 00             	ret    $0x2
    16ad:	fc                   	cld    
    16ae:	ad                   	lods   %ds:(%si),%ax
    16af:	23 c0                	and    %ax,%ax
    16b1:	74 03                	je     0x16b6
    16b3:	ab                   	stos   %ax,%es:(%di)
    16b4:	eb f8                	jmp    0x16ae
    16b6:	c3                   	ret    
    16b7:	50                   	push   %ax
    16b8:	1e                   	push   %ds
    16b9:	b8 00 3e             	mov    $0x3e00,%ax
    16bc:	8e d8                	mov    %ax,%ds
    16be:	33 c0                	xor    %ax,%ax
    16c0:	e4 ee                	in     $0xee,%al
    16c2:	a3 10 00             	mov    %ax,0x10
    16c5:	b0 20                	mov    $0x20,%al
    16c7:	e6 00                	out    %al,$0x0
    16c9:	1f                   	pop    %ds
    16ca:	58                   	pop    %ax
    16cb:	cf                   	iret   
    16cc:	55                   	push   %bp
    16cd:	8b ec                	mov    %sp,%bp
    16cf:	8b 46 0c             	mov    0xc(%bp),%ax
    16d2:	a3 12 00             	mov    %ax,0x12
    16d5:	8b 46 0a             	mov    0xa(%bp),%ax
    16d8:	a3 14 00             	mov    %ax,0x14
    16db:	8b 46 08             	mov    0x8(%bp),%ax
    16de:	a3 16 00             	mov    %ax,0x16
    16e1:	8b 46 06             	mov    0x6(%bp),%ax
    16e4:	a3 18 00             	mov    %ax,0x18
    16e7:	8b 46 04             	mov    0x4(%bp),%ax
    16ea:	a3 1a 00             	mov    %ax,0x1a
    16ed:	5d                   	pop    %bp
    16ee:	e8 7f 03             	call   0x1a70
    16f1:	e8 71 02             	call   0x1965
    16f4:	3d 00 00             	cmp    $0x0,%ax
    16f7:	75 03                	jne    0x16fc
    16f9:	e8 03 00             	call   0x16ff
    16fc:	c2 0a 00             	ret    $0xa
    16ff:	a1 14 00             	mov    0x14,%ax
    1702:	e8 7e 02             	call   0x1983
    1705:	a2 1e 00             	mov    %al,0x1e
    1708:	89 0e 1f 00          	mov    %cx,0x1f
    170c:	80 26 21 00 f8       	andb   $0xf8,0x21
    1711:	08 1e 21 00          	or     %bl,0x21
    1715:	88 1e 23 00          	mov    %bl,0x23
    1719:	bb 10 00             	mov    $0x10,%bx
    171c:	2b d8                	sub    %ax,%bx
    171e:	3b 1e 2c 00          	cmp    0x2c,%bx
    1722:	76 04                	jbe    0x1728
    1724:	8b 1e 2c 00          	mov    0x2c,%bx
    1728:	3b 1e 16 00          	cmp    0x16,%bx
    172c:	76 04                	jbe    0x1732
    172e:	8b 1e 16 00          	mov    0x16,%bx
    1732:	88 1e 1d 00          	mov    %bl,0x1d
    1736:	c6 06 22 00 2c       	movb   $0x2c,0x22
    173b:	b0 01                	mov    $0x1,%al
    173d:	e8 23 03             	call   0x1a63
    1740:	ba e8 01             	mov    $0x1e8,%dx
    1743:	b0 01                	mov    $0x1,%al
    1745:	ee                   	out    %al,(%dx)
    1746:	e8 69 02             	call   0x19b2
    1749:	75 06                	jne    0x1751
    174b:	e8 ab 02             	call   0x19f9
    174e:	e8 c1 02             	call   0x1a12
    1751:	50                   	push   %ax
    1752:	ba e8 01             	mov    $0x1e8,%dx
    1755:	33 c0                	xor    %ax,%ax
    1757:	ee                   	out    %al,(%dx)
    1758:	e8 08 03             	call   0x1a63
    175b:	58                   	pop    %ax
    175c:	3d 00 00             	cmp    $0x0,%ax
    175f:	75 37                	jne    0x1798
    1761:	33 c9                	xor    %cx,%cx
    1763:	8a 2e 1d 00          	mov    0x1d,%ch
    1767:	d1 e1                	shl    %cx
    1769:	8b 3e 1a 00          	mov    0x1a,%di
    176d:	ba f0 01             	mov    $0x1f0,%dx
    1770:	fc                   	cld    
    1771:	06                   	push   %es
    1772:	8e 06 18 00          	mov    0x18,%es
    1776:	ec                   	in     (%dx),%al
    1777:	aa                   	stos   %al,%es:(%di)
    1778:	e2 fc                	loop   0x1776
    177a:	07                   	pop    %es
    177b:	33 c0                	xor    %ax,%ax
    177d:	a0 1d 00             	mov    0x1d,%al
    1780:	29 06 16 00          	sub    %ax,0x16
    1784:	74 0f                	je     0x1795
    1786:	01 06 14 00          	add    %ax,0x14
    178a:	b1 05                	mov    $0x5,%cl
    178c:	d3 e0                	shl    %cl,%ax
    178e:	01 06 18 00          	add    %ax,0x18
    1792:	e9 6a ff             	jmp    0x16ff
    1795:	b8 00 00             	mov    $0x0,%ax
    1798:	c3                   	ret    
    1799:	c7 06 24 00 00 00    	movw   $0x0,0x24
    179f:	c7 06 2c 00 10 00    	movw   $0x10,0x2c
    17a5:	33 c0                	xor    %ax,%ax
    17a7:	e8 b9 02             	call   0x1a63
    17aa:	b9 00 08             	mov    $0x800,%cx
    17ad:	ba f0 01             	mov    $0x1f0,%dx
    17b0:	b0 55                	mov    $0x55,%al
    17b2:	ee                   	out    %al,(%dx)
    17b3:	e2 fd                	loop   0x17b2
    17b5:	f6 d0                	not    %al
    17b7:	ee                   	out    %al,(%dx)
    17b8:	33 c0                	xor    %ax,%ax
    17ba:	e8 a6 02             	call   0x1a63
    17bd:	b4 55                	mov    $0x55,%ah
    17bf:	ba f0 01             	mov    $0x1f0,%dx
    17c2:	ec                   	in     (%dx),%al
    17c3:	3a c4                	cmp    %ah,%al
    17c5:	74 1c                	je     0x17e3
    17c7:	f6 d4                	not    %ah
    17c9:	c7 06 2c 00 04 00    	movw   $0x4,0x2c
    17cf:	3a c4                	cmp    %ah,%al
    17d1:	74 10                	je     0x17e3
    17d3:	c6 06 4f 10 00       	movb   $0x0,0x104f
    17d8:	c6 06 4c 10 00       	movb   $0x0,0x104c
    17dd:	b8 0c 80             	mov    $0x800c,%ax
    17e0:	e9 87 00             	jmp    0x186a
    17e3:	c6 06 4f 10 01       	movb   $0x1,0x104f
    17e8:	c6 06 4c 10 04       	movb   $0x4,0x104c
    17ed:	9c                   	pushf  
    17ee:	fa                   	cli    
    17ef:	e4 02                	in     $0x2,%al
    17f1:	24 fb                	and    $0xfb,%al
    17f3:	e6 02                	out    %al,$0x2
    17f5:	9d                   	popf   
    17f6:	c6 06 1c 00 ff       	movb   $0xff,0x1c
    17fb:	c6 06 1d 00 01       	movb   $0x1,0x1d
    1800:	c6 06 1e 00 00       	movb   $0x0,0x1e
    1805:	c7 06 1f 00 00 00    	movw   $0x0,0x1f
    180b:	c6 06 21 00 20       	movb   $0x20,0x21
    1810:	c6 06 23 00 00       	movb   $0x0,0x23
    1815:	c7 06 27 00 03 00    	movw   $0x3,0x27
    181b:	c7 06 2a 00 03 00    	movw   $0x3,0x2a
    1821:	c6 06 26 00 02       	movb   $0x2,0x26
    1826:	c6 06 29 00 02       	movb   $0x2,0x29
    182b:	c7 06 12 00 00 00    	movw   $0x0,0x12
    1831:	e8 3c 02             	call   0x1a70
    1834:	c7 06 24 00 e8 03    	movw   $0x3e8,0x24
    183a:	e8 3d 00             	call   0x187a
    183d:	23 c0                	and    %ax,%ax
    183f:	75 29                	jne    0x186a
    1841:	ba e6 01             	mov    $0x1e6,%dx
    1844:	b0 00                	mov    $0x0,%al
    1846:	ee                   	out    %al,(%dx)
    1847:	b1 c8                	mov    $0xc8,%cl
    1849:	d3 e1                	shl    %cl,%cx
    184b:	e4 ee                	in     $0xee,%al
    184d:	a8 40                	test   $0x40,%al
    184f:	b8 00 00             	mov    $0x0,%ax
    1852:	75 16                	jne    0x186a
    1854:	fe 06 4f 10          	incb   0x104f
    1858:	c7 06 12 00 01 00    	movw   $0x1,0x12
    185e:	e8 0f 02             	call   0x1a70
    1861:	c7 06 24 00 64 00    	movw   $0x64,0x24
    1867:	e8 10 00             	call   0x187a
    186a:	8b d8                	mov    %ax,%bx
    186c:	ba ee 01             	mov    $0x1ee,%dx
    186f:	33 c0                	xor    %ax,%ax
    1871:	ee                   	out    %al,(%dx)
    1872:	40                   	inc    %ax
    1873:	ba e6 01             	mov    $0x1e6,%dx
    1876:	ee                   	out    %al,(%dx)
    1877:	8b c3                	mov    %bx,%ax
    1879:	c3                   	ret    
    187a:	e4 ee                	in     $0xee,%al
    187c:	a8 40                	test   $0x40,%al
    187e:	75 0f                	jne    0x188f
    1880:	83 3e 24 00 00       	cmpw   $0x0,0x24
    1885:	75 f3                	jne    0x187a
    1887:	fe 0e 4f 10          	decb   0x104f
    188b:	b8 02 80             	mov    $0x8002,%ax
    188e:	c3                   	ret    
    188f:	80 3e 0a 00 01       	cmpb   $0x1,0xa
    1894:	75 3c                	jne    0x18d2
    1896:	c6 06 22 00 40       	movb   $0x40,0x22
    189b:	e8 b8 00             	call   0x1956
    189e:	75 32                	jne    0x18d2
    18a0:	e4 ea                	in     $0xea,%al
    18a2:	8a e0                	mov    %al,%ah
    18a4:	e4 e8                	in     $0xe8,%al
    18a6:	3d 00 00             	cmp    $0x0,%ax
    18a9:	74 03                	je     0x18ae
    18ab:	48                   	dec    %ax
    18ac:	eb 01                	jmp    0x18af
    18ae:	40                   	inc    %ax
    18af:	a3 1f 00             	mov    %ax,0x1f
    18b2:	c6 06 22 00 70       	movb   $0x70,0x22
    18b7:	e8 9c 00             	call   0x1956
    18ba:	75 16                	jne    0x18d2
    18bc:	c6 06 22 00 40       	movb   $0x40,0x22
    18c1:	e8 92 00             	call   0x1956
    18c4:	75 0c                	jne    0x18d2
    18c6:	e4 ea                	in     $0xea,%al
    18c8:	8a e0                	mov    %al,%ah
    18ca:	e4 e8                	in     $0xe8,%al
    18cc:	3b 06 1f 00          	cmp    0x1f,%ax
    18d0:	74 21                	je     0x18f3
    18d2:	c7 06 1f 00 00 00    	movw   $0x0,0x1f
    18d8:	c6 06 22 00 10       	movb   $0x10,0x22
    18dd:	e8 d2 00             	call   0x19b2
    18e0:	75 73                	jne    0x1955
    18e2:	c7 06 24 00 ee 02    	movw   $0x2ee,0x24
    18e8:	e8 14 01             	call   0x19ff
    18eb:	e8 24 01             	call   0x1a12
    18ee:	3d 00 00             	cmp    $0x0,%ax
    18f1:	75 62                	jne    0x1955
    18f3:	33 c0                	xor    %ax,%ax
    18f5:	a3 14 00             	mov    %ax,0x14
    18f8:	40                   	inc    %ax
    18f9:	a3 16 00             	mov    %ax,0x16
    18fc:	8c 1e 18 00          	mov    %ds,0x18
    1900:	c7 06 1a 00 30 00    	movw   $0x30,0x1a
    1906:	e8 f6 fd             	call   0x16ff
    1909:	3d 00 00             	cmp    $0x0,%ax
    190c:	b0 04                	mov    $0x4,%al
    190e:	75 42                	jne    0x1952
    1910:	8a 1e 8d 00          	mov    0x8d,%bl
    1914:	80 fb 03             	cmp    $0x3,%bl
    1917:	72 07                	jb     0x1920
    1919:	80 fb 05             	cmp    $0x5,%bl
    191c:	77 02                	ja     0x1920
    191e:	8a c3                	mov    %bl,%al
    1920:	83 3e 12 00 00       	cmpw   $0x0,0x12
    1925:	75 03                	jne    0x192a
    1927:	a2 4c 10             	mov    %al,0x104c
    192a:	8d 1e 26 00          	lea    0x26,%bx
    192e:	8d 36 27 00          	lea    0x27,%si
    1932:	83 3e 12 00 01       	cmpw   $0x1,0x12
    1937:	75 08                	jne    0x1941
    1939:	8d 1e 29 00          	lea    0x29,%bx
    193d:	8d 36 2a 00          	lea    0x2a,%si
    1941:	fe c8                	dec    %al
    1943:	fe c8                	dec    %al
    1945:	88 07                	mov    %al,(%bx)
    1947:	8a c8                	mov    %al,%cl
    1949:	33 c0                	xor    %ax,%ax
    194b:	48                   	dec    %ax
    194c:	d3 e0                	shl    %cl,%ax
    194e:	f7 d0                	not    %ax
    1950:	89 04                	mov    %ax,(%si)
    1952:	b8 00 00             	mov    $0x0,%ax
    1955:	c3                   	ret    
    1956:	e8 59 00             	call   0x19b2
    1959:	75 09                	jne    0x1964
    195b:	e8 9b 00             	call   0x19f9
    195e:	e8 b1 00             	call   0x1a12
    1961:	3d 00 00             	cmp    $0x0,%ax
    1964:	c3                   	ret    
    1965:	a1 12 00             	mov    0x12,%ax
    1968:	3a 06 4f 10          	cmp    0x104f,%al
    196c:	72 05                	jb     0x1973
    196e:	b8 01 80             	mov    $0x8001,%ax
    1971:	eb 0f                	jmp    0x1982
    1973:	a1 16 00             	mov    0x16,%ax
    1976:	23 c0                	and    %ax,%ax
    1978:	75 05                	jne    0x197f
    197a:	b8 0c 80             	mov    $0x800c,%ax
    197d:	eb 03                	jmp    0x1982
    197f:	b8 00 00             	mov    $0x0,%ax
    1982:	c3                   	ret    
    1983:	8a 2e 26 00          	mov    0x26,%ch
    1987:	8b 16 27 00          	mov    0x27,%dx
    198b:	83 3e 12 00 01       	cmpw   $0x1,0x12
    1990:	75 08                	jne    0x199a
    1992:	8a 2e 29 00          	mov    0x29,%ch
    1996:	8b 16 2a 00          	mov    0x2a,%dx
    199a:	50                   	push   %ax
    199b:	b1 04                	mov    $0x4,%cl
    199d:	d3 e8                	shr    %cl,%ax
    199f:	8b d8                	mov    %ax,%bx
    19a1:	23 da                	and    %dx,%bx
    19a3:	8a cd                	mov    %ch,%cl
    19a5:	d3 e8                	shr    %cl,%ax
    19a7:	8b c8                	mov    %ax,%cx
    19a9:	81 e1 ff 01          	and    $0x1ff,%cx
    19ad:	58                   	pop    %ax
    19ae:	25 0f 00             	and    $0xf,%ax
    19b1:	c3                   	ret    
    19b2:	c7 06 24 00 19 00    	movw   $0x19,0x24
    19b8:	e4 ee                	in     $0xee,%al
    19ba:	a8 82                	test   $0x82,%al
    19bc:	74 0c                	je     0x19ca
    19be:	80 3e 24 00 00       	cmpb   $0x0,0x24
    19c3:	75 f3                	jne    0x19b8
    19c5:	b8 0c 80             	mov    $0x800c,%ax
    19c8:	eb 2c                	jmp    0x19f6
    19ca:	a8 40                	test   $0x40,%al
    19cc:	74 f0                	je     0x19be
    19ce:	b8 ff ff             	mov    $0xffff,%ax
    19d1:	a3 10 00             	mov    %ax,0x10
    19d4:	b9 03 00             	mov    $0x3,%cx
    19d7:	ba e0 01             	mov    $0x1e0,%dx
    19da:	a0 23 00             	mov    0x23,%al
    19dd:	ee                   	out    %al,(%dx)
    19de:	d0 e8                	shr    %al
    19e0:	42                   	inc    %dx
    19e1:	42                   	inc    %dx
    19e2:	e2 f9                	loop   0x19dd
    19e4:	fc                   	cld    
    19e5:	b9 07 00             	mov    $0x7,%cx
    19e8:	ba e2 00             	mov    $0xe2,%dx
    19eb:	be 1c 00             	mov    $0x1c,%si
    19ee:	ac                   	lods   %ds:(%si),%al
    19ef:	ee                   	out    %al,(%dx)
    19f0:	42                   	inc    %dx
    19f1:	42                   	inc    %dx
    19f2:	e2 fa                	loop   0x19ee
    19f4:	33 c0                	xor    %ax,%ax
    19f6:	23 c0                	and    %ax,%ax
    19f8:	c3                   	ret    
    19f9:	c7 06 24 00 19 00    	movw   $0x19,0x24
    19ff:	81 3e 10 00 ff ff    	cmpw   $0xffff,0x10
    1a05:	75 07                	jne    0x1a0e
    1a07:	83 3e 24 00 00       	cmpw   $0x0,0x24
    1a0c:	75 f1                	jne    0x19ff
    1a0e:	a1 10 00             	mov    0x10,%ax
    1a11:	c3                   	ret    
    1a12:	3d ff ff             	cmp    $0xffff,%ax
    1a15:	74 04                	je     0x1a1b
    1a17:	a8 a2                	test   $0xa2,%al
    1a19:	74 05                	je     0x1a20
    1a1b:	b8 0c 80             	mov    $0x800c,%ax
    1a1e:	eb 36                	jmp    0x1a56
    1a20:	a8 01                	test   $0x1,%al
    1a22:	74 2f                	je     0x1a53
    1a24:	e4 e2                	in     $0xe2,%al
    1a26:	a8 80                	test   $0x80,%al
    1a28:	74 05                	je     0x1a2f
    1a2a:	b8 07 80             	mov    $0x8007,%ax
    1a2d:	eb 27                	jmp    0x1a56
    1a2f:	a8 40                	test   $0x40,%al
    1a31:	74 05                	je     0x1a38
    1a33:	b8 04 80             	mov    $0x8004,%ax
    1a36:	eb 1e                	jmp    0x1a56
    1a38:	a8 11                	test   $0x11,%al
    1a3a:	74 05                	je     0x1a41
    1a3c:	b8 08 80             	mov    $0x8008,%ax
    1a3f:	eb 15                	jmp    0x1a56
    1a41:	a8 04                	test   $0x4,%al
    1a43:	74 05                	je     0x1a4a
    1a45:	b8 0c 80             	mov    $0x800c,%ax
    1a48:	eb 0c                	jmp    0x1a56
    1a4a:	a8 02                	test   $0x2,%al
    1a4c:	74 05                	je     0x1a53
    1a4e:	b8 06 80             	mov    $0x8006,%ax
    1a51:	eb 03                	jmp    0x1a56
    1a53:	b8 00 00             	mov    $0x0,%ax
    1a56:	c3                   	ret    
    1a57:	80 3e 24 00 00       	cmpb   $0x0,0x24
    1a5c:	74 04                	je     0x1a62
    1a5e:	fe 0e 24 00          	decb   0x24
    1a62:	c3                   	ret    
    1a63:	ba ec 01             	mov    $0x1ec,%dx
    1a66:	ee                   	out    %al,(%dx)
    1a67:	4a                   	dec    %dx
    1a68:	4a                   	dec    %dx
    1a69:	b0 01                	mov    $0x1,%al
    1a6b:	ee                   	out    %al,(%dx)
    1a6c:	b0 00                	mov    $0x0,%al
    1a6e:	ee                   	out    %al,(%dx)
    1a6f:	c3                   	ret    
    1a70:	e4 ee                	in     $0xee,%al
    1a72:	a8 82                	test   $0x82,%al
    1a74:	75 fa                	jne    0x1a70
    1a76:	80 26 21 00 e7       	andb   $0xe7,0x21
    1a7b:	83 3e 12 00 01       	cmpw   $0x1,0x12
    1a80:	74 0c                	je     0x1a8e
    1a82:	ba ee 01             	mov    $0x1ee,%dx
    1a85:	33 c0                	xor    %ax,%ax
    1a87:	ee                   	out    %al,(%dx)
    1a88:	40                   	inc    %ax
    1a89:	ba e6 01             	mov    $0x1e6,%dx
    1a8c:	ee                   	out    %al,(%dx)
    1a8d:	c3                   	ret    
    1a8e:	80 0e 21 00 08       	orb    $0x8,0x21
    1a93:	ba e6 01             	mov    $0x1e6,%dx
    1a96:	33 c0                	xor    %ax,%ax
    1a98:	ee                   	out    %al,(%dx)
    1a99:	40                   	inc    %ax
    1a9a:	ba ee 01             	mov    $0x1ee,%dx
    1a9d:	ee                   	out    %al,(%dx)
    1a9e:	c3                   	ret    
    1a9f:	50                   	push   %ax
    1aa0:	53                   	push   %bx
    1aa1:	51                   	push   %cx
    1aa2:	52                   	push   %dx
    1aa3:	55                   	push   %bp
    1aa4:	56                   	push   %si
    1aa5:	57                   	push   %di
    1aa6:	06                   	push   %es
    1aa7:	1e                   	push   %ds
    1aa8:	ba 00 3e             	mov    $0x3e00,%dx
    1aab:	8e da                	mov    %dx,%ds
    1aad:	8e c2                	mov    %dx,%es
    1aaf:	33 ed                	xor    %bp,%bp
    1ab1:	fb                   	sti    
    1ab2:	e8 a2 ff             	call   0x1a57
    1ab5:	e8 12 fb             	call   0x15ca
    1ab8:	83 3e 04 00 00       	cmpw   $0x0,0x4
    1abd:	74 04                	je     0x1ac3
    1abf:	ff 0e 04 00          	decw   0x4
    1ac3:	83 3e 06 00 00       	cmpw   $0x0,0x6
    1ac8:	74 04                	je     0x1ace
    1aca:	ff 0e 06 00          	decw   0x6
    1ace:	83 3e 02 00 00       	cmpw   $0x0,0x2
    1ad3:	74 04                	je     0x1ad9
    1ad5:	ff 0e 02 00          	decw   0x2
    1ad9:	33 c9                	xor    %cx,%cx
    1adb:	8b c1                	mov    %cx,%ax
    1add:	bb 88 13             	mov    $0x1388,%bx
    1ae0:	fa                   	cli    
    1ae1:	e6 5e                	out    %al,$0x5e
    1ae3:	e4 58                	in     $0x58,%al
    1ae5:	8a e0                	mov    %al,%ah
    1ae7:	e4 58                	in     $0x58,%al
    1ae9:	86 c4                	xchg   %al,%ah
    1aeb:	03 c3                	add    %bx,%ax
    1aed:	41                   	inc    %cx
    1aee:	3b c3                	cmp    %bx,%ax
    1af0:	73 f9                	jae    0x1aeb
    1af2:	2b c1                	sub    %cx,%ax
    1af4:	2b c1                	sub    %cx,%ax
    1af6:	2d 07 00             	sub    $0x7,%ax
    1af9:	e6 58                	out    %al,$0x58
    1afb:	8a c4                	mov    %ah,%al
    1afd:	e6 58                	out    %al,$0x58
    1aff:	b0 20                	mov    $0x20,%al
    1b01:	e6 00                	out    %al,$0x0
    1b03:	1f                   	pop    %ds
    1b04:	07                   	pop    %es
    1b05:	5f                   	pop    %di
    1b06:	5e                   	pop    %si
    1b07:	5d                   	pop    %bp
    1b08:	5a                   	pop    %dx
    1b09:	59                   	pop    %cx
    1b0a:	5b                   	pop    %bx
    1b0b:	58                   	pop    %ax
    1b0c:	cf                   	iret   
    1b0d:	9c                   	pushf  
    1b0e:	fa                   	cli    
    1b0f:	b0 30                	mov    $0x30,%al
    1b11:	e6 5e                	out    %al,$0x5e
    1b13:	b8 88 13             	mov    $0x1388,%ax
    1b16:	e6 58                	out    %al,$0x58
    1b18:	8a c4                	mov    %ah,%al
    1b1a:	e6 58                	out    %al,$0x58
    1b1c:	e4 02                	in     $0x2,%al
    1b1e:	24 bf                	and    $0xbf,%al
    1b20:	e6 02                	out    %al,$0x2
    1b22:	9d                   	popf   
    1b23:	c3                   	ret    
    1b24:	55                   	push   %bp
    1b25:	8b ec                	mov    %sp,%bp
    1b27:	2b 26 98 10          	sub    0x1098,%sp
    1b2b:	e8 9c 04             	call   0x1fca
    1b2e:	e8 8d 05             	call   0x20be
    1b31:	e4 40                	in     $0x40,%al
    1b33:	88 46 fd             	mov    %al,-0x3(%bp)
    1b36:	8a 46 fd             	mov    -0x3(%bp),%al
    1b39:	24 80                	and    $0x80,%al
    1b3b:	0a c0                	or     %al,%al
    1b3d:	74 07                	je     0x1b46
    1b3f:	c7 46 fe 02 80       	movw   $0x8002,-0x2(%bp)
    1b44:	eb 45                	jmp    0x1b8b
    1b46:	8a 46 fd             	mov    -0x3(%bp),%al
    1b49:	24 10                	and    $0x10,%al
    1b4b:	0a c0                	or     %al,%al
    1b4d:	74 07                	je     0x1b56
    1b4f:	c7 46 fe 08 80       	movw   $0x8008,-0x2(%bp)
    1b54:	eb 35                	jmp    0x1b8b
    1b56:	8a 46 fd             	mov    -0x3(%bp),%al
    1b59:	24 08                	and    $0x8,%al
    1b5b:	0a c0                	or     %al,%al
    1b5d:	74 07                	je     0x1b66
    1b5f:	c7 46 fe 04 80       	movw   $0x8004,-0x2(%bp)
    1b64:	eb 25                	jmp    0x1b8b
    1b66:	8a 46 fd             	mov    -0x3(%bp),%al
    1b69:	24 04                	and    $0x4,%al
    1b6b:	0a c0                	or     %al,%al
    1b6d:	74 07                	je     0x1b76
    1b6f:	c7 46 fe 0c 80       	movw   $0x800c,-0x2(%bp)
    1b74:	eb 15                	jmp    0x1b8b
    1b76:	8a 46 fd             	mov    -0x3(%bp),%al
    1b79:	24 40                	and    $0x40,%al
    1b7b:	0a c0                	or     %al,%al
    1b7d:	74 07                	je     0x1b86
    1b7f:	c7 46 fe 00 80       	movw   $0x8000,-0x2(%bp)
    1b84:	eb 05                	jmp    0x1b8b
    1b86:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1b8b:	8b 46 fe             	mov    -0x2(%bp),%ax
    1b8e:	8b e5                	mov    %bp,%sp
    1b90:	5d                   	pop    %bp
    1b91:	c3                   	ret    
    1b92:	55                   	push   %bp
    1b93:	8b ec                	mov    %sp,%bp
    1b95:	2b 26 9a 10          	sub    0x109a,%sp
    1b99:	a0 4d 10             	mov    0x104d,%al
    1b9c:	3a 06 8d 00          	cmp    0x8d,%al
    1ba0:	73 07                	jae    0x1ba9
    1ba2:	c7 46 fc 07 80       	movw   $0x8007,-0x4(%bp)
    1ba7:	eb 5f                	jmp    0x1c08
    1ba9:	ff 76 08             	push   0x8(%bp)
    1bac:	e8 ef 01             	call   0x1d9e
    1baf:	89 46 fc             	mov    %ax,-0x4(%bp)
    1bb2:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1bb6:	75 50                	jne    0x1c08
    1bb8:	e8 7d 02             	call   0x1e38
    1bbb:	89 46 fc             	mov    %ax,-0x4(%bp)
    1bbe:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1bc2:	75 44                	jne    0x1c08
    1bc4:	33 c0                	xor    %ax,%ax
    1bc6:	8b 5e 06             	mov    0x6(%bp),%bx
    1bc9:	3b 1e 88 00          	cmp    0x88,%bx
    1bcd:	89 46 fa             	mov    %ax,-0x6(%bp)
    1bd0:	8b 4e 06             	mov    0x6(%bp),%cx
    1bd3:	89 4e f8             	mov    %cx,-0x8(%bp)
    1bd6:	73 2b                	jae    0x1c03
    1bd8:	33 db                	xor    %bx,%bx
    1bda:	83 7e 04 01          	cmpw   $0x1,0x4(%bp)
    1bde:	89 5e f6             	mov    %bx,-0xa(%bp)
    1be1:	8b 4e 04             	mov    0x4(%bp),%cx
    1be4:	89 4e f4             	mov    %cx,-0xc(%bp)
    1be7:	72 1a                	jb     0x1c03
    1be9:	33 c9                	xor    %cx,%cx
    1beb:	8b 56 f8             	mov    -0x8(%bp),%dx
    1bee:	8b 76 fa             	mov    -0x6(%bp),%si
    1bf1:	03 56 f4             	add    -0xc(%bp),%dx
    1bf4:	13 76 f6             	adc    -0xa(%bp),%si
    1bf7:	3b f1                	cmp    %cx,%si
    1bf9:	7f 08                	jg     0x1c03
    1bfb:	7c 0b                	jl     0x1c08
    1bfd:	3b 16 88 00          	cmp    0x88,%dx
    1c01:	76 05                	jbe    0x1c08
    1c03:	c7 46 fc 08 80       	movw   $0x8008,-0x4(%bp)
    1c08:	8b 46 fc             	mov    -0x4(%bp),%ax
    1c0b:	89 46 fe             	mov    %ax,-0x2(%bp)
    1c0e:	8b 46 fe             	mov    -0x2(%bp),%ax
    1c11:	8b e5                	mov    %bp,%sp
    1c13:	5d                   	pop    %bp
    1c14:	c2 06 00             	ret    $0x6
    1c17:	55                   	push   %bp
    1c18:	8b ec                	mov    %sp,%bp
    1c1a:	2b 26 9c 10          	sub    0x109c,%sp
    1c1e:	ff 76 0c             	push   0xc(%bp)
    1c21:	33 c0                	xor    %ax,%ax
    1c23:	ff 76 0a             	push   0xa(%bp)
    1c26:	ff 76 08             	push   0x8(%bp)
    1c29:	89 46 e9             	mov    %ax,-0x17(%bp)
    1c2c:	e8 63 ff             	call   0x1b92
    1c2f:	89 46 fc             	mov    %ax,-0x4(%bp)
    1c32:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1c36:	74 03                	je     0x1c3b
    1c38:	e9 53 01             	jmp    0x1d8e
    1c3b:	8b 46 0a             	mov    0xa(%bp),%ax
    1c3e:	03 46 08             	add    0x8(%bp),%ax
    1c41:	48                   	dec    %ax
    1c42:	33 db                	xor    %bx,%bx
    1c44:	89 46 f3             	mov    %ax,-0xd(%bp)
    1c47:	89 46 e7             	mov    %ax,-0x19(%bp)
    1c4a:	8b 46 0a             	mov    0xa(%bp),%ax
    1c4d:	8b 56 e9             	mov    -0x17(%bp),%dx
    1c50:	b9 09 00             	mov    $0x9,%cx
    1c53:	f7 f1                	div    %cx
    1c55:	89 46 f1             	mov    %ax,-0xf(%bp)
    1c58:	89 46 e5             	mov    %ax,-0x1b(%bp)
    1c5b:	8b 46 e7             	mov    -0x19(%bp),%ax
    1c5e:	8b d3                	mov    %bx,%dx
    1c60:	bb 09 00             	mov    $0x9,%bx
    1c63:	f7 f3                	div    %bx
    1c65:	89 46 ef             	mov    %ax,-0x11(%bp)
    1c68:	8b 5e f1             	mov    -0xf(%bp),%bx
    1c6b:	3b d8                	cmp    %ax,%bx
    1c6d:	76 03                	jbe    0x1c72
    1c6f:	e9 1c 01             	jmp    0x1d8e
    1c72:	89 46 e3             	mov    %ax,-0x1d(%bp)
    1c75:	89 5e f7             	mov    %bx,-0x9(%bp)
    1c78:	8b 46 f1             	mov    -0xf(%bp),%ax
    1c7b:	3b 46 f7             	cmp    -0x9(%bp),%ax
    1c7e:	73 14                	jae    0x1c94
    1c80:	b8 0a 00             	mov    $0xa,%ax
    1c83:	2b 46 f5             	sub    -0xb(%bp),%ax
    1c86:	b1 05                	mov    $0x5,%cl
    1c88:	d3 e0                	shl    %cl,%ax
    1c8a:	01 46 06             	add    %ax,0x6(%bp)
    1c8d:	c7 46 f5 01 00       	movw   $0x1,-0xb(%bp)
    1c92:	eb 13                	jmp    0x1ca7
    1c94:	33 c0                	xor    %ax,%ax
    1c96:	8b d0                	mov    %ax,%dx
    1c98:	8b 46 0a             	mov    0xa(%bp),%ax
    1c9b:	bb 09 00             	mov    $0x9,%bx
    1c9e:	f7 f3                	div    %bx
    1ca0:	fe c2                	inc    %dl
    1ca2:	32 f6                	xor    %dh,%dh
    1ca4:	89 56 f5             	mov    %dx,-0xb(%bp)
    1ca7:	8b 46 f7             	mov    -0x9(%bp),%ax
    1caa:	3b 46 ef             	cmp    -0x11(%bp),%ax
    1cad:	73 0b                	jae    0x1cba
    1caf:	b8 0a 00             	mov    $0xa,%ax
    1cb2:	2b 46 f5             	sub    -0xb(%bp),%ax
    1cb5:	89 46 ed             	mov    %ax,-0x13(%bp)
    1cb8:	eb 17                	jmp    0x1cd1
    1cba:	33 c0                	xor    %ax,%ax
    1cbc:	8b d0                	mov    %ax,%dx
    1cbe:	8b 46 f3             	mov    -0xd(%bp),%ax
    1cc1:	bb 09 00             	mov    $0x9,%bx
    1cc4:	f7 f3                	div    %bx
    1cc6:	80 c2 02             	add    $0x2,%dl
    1cc9:	32 f6                	xor    %dh,%dh
    1ccb:	2b 56 f5             	sub    -0xb(%bp),%dx
    1cce:	89 56 ed             	mov    %dx,-0x13(%bp)
    1cd1:	c7 46 fa 0a 00       	movw   $0xa,-0x6(%bp)
    1cd6:	c6 46 f9 01          	movb   $0x1,-0x7(%bp)
    1cda:	33 c0                	xor    %ax,%ax
    1cdc:	83 7e fa 00          	cmpw   $0x0,-0x6(%bp)
    1ce0:	89 46 e1             	mov    %ax,-0x1f(%bp)
    1ce3:	8b 4e fa             	mov    -0x6(%bp),%cx
    1ce6:	89 4e df             	mov    %cx,-0x21(%bp)
    1ce9:	77 03                	ja     0x1cee
    1ceb:	e9 8b 00             	jmp    0x1d79
    1cee:	8a 5e f9             	mov    -0x7(%bp),%bl
    1cf1:	0a db                	or     %bl,%bl
    1cf3:	75 03                	jne    0x1cf8
    1cf5:	e9 81 00             	jmp    0x1d79
    1cf8:	89 46 dd             	mov    %ax,-0x23(%bp)
    1cfb:	8b 46 df             	mov    -0x21(%bp),%ax
    1cfe:	8b 56 e1             	mov    -0x1f(%bp),%dx
    1d01:	bb 03 00             	mov    $0x3,%bx
    1d04:	f7 f3                	div    %bx
    1d06:	0a d2                	or     %dl,%dl
    1d08:	75 06                	jne    0x1d10
    1d0a:	e8 d0 01             	call   0x1edd
    1d0d:	89 46 fc             	mov    %ax,-0x4(%bp)
    1d10:	80 3e 8d 00 02       	cmpb   $0x2,0x8d
    1d15:	74 10                	je     0x1d27
    1d17:	ff 76 f7             	push   -0x9(%bp)
    1d1a:	e8 4c 01             	call   0x1e69
    1d1d:	89 46 fc             	mov    %ax,-0x4(%bp)
    1d20:	c7 46 eb 00 00       	movw   $0x0,-0x15(%bp)
    1d25:	eb 15                	jmp    0x1d3c
    1d27:	8b 46 f7             	mov    -0x9(%bp),%ax
    1d2a:	d1 e8                	shr    %ax
    1d2c:	50                   	push   %ax
    1d2d:	e8 39 01             	call   0x1e69
    1d30:	89 46 fc             	mov    %ax,-0x4(%bp)
    1d33:	8a 46 f7             	mov    -0x9(%bp),%al
    1d36:	24 01                	and    $0x1,%al
    1d38:	98                   	cbtw   
    1d39:	89 46 eb             	mov    %ax,-0x15(%bp)
    1d3c:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1d40:	75 18                	jne    0x1d5a
    1d42:	ff 76 f5             	push   -0xb(%bp)
    1d45:	ff 76 ed             	push   -0x13(%bp)
    1d48:	ff 76 06             	push   0x6(%bp)
    1d4b:	ff 76 04             	push   0x4(%bp)
    1d4e:	ff 76 eb             	push   -0x15(%bp)
    1d51:	e8 84 02             	call   0x1fd8
    1d54:	e8 cd fd             	call   0x1b24
    1d57:	89 46 fc             	mov    %ax,-0x4(%bp)
    1d5a:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1d5e:	75 04                	jne    0x1d64
    1d60:	b0 01                	mov    $0x1,%al
    1d62:	eb 02                	jmp    0x1d66
    1d64:	32 c0                	xor    %al,%al
    1d66:	34 01                	xor    $0x1,%al
    1d68:	88 46 f9             	mov    %al,-0x7(%bp)
    1d6b:	0a c0                	or     %al,%al
    1d6d:	74 04                	je     0x1d73
    1d6f:	b0 d0                	mov    $0xd0,%al
    1d71:	e6 40                	out    %al,$0x40
    1d73:	ff 4e fa             	decw   -0x6(%bp)
    1d76:	e9 61 ff             	jmp    0x1cda
    1d79:	8a 46 f9             	mov    -0x7(%bp),%al
    1d7c:	0a c0                	or     %al,%al
    1d7e:	74 02                	je     0x1d82
    1d80:	eb 0c                	jmp    0x1d8e
    1d82:	8b 5e f7             	mov    -0x9(%bp),%bx
    1d85:	3b 5e e3             	cmp    -0x1d(%bp),%bx
    1d88:	74 04                	je     0x1d8e
    1d8a:	43                   	inc    %bx
    1d8b:	e9 e7 fe             	jmp    0x1c75
    1d8e:	8b 46 fc             	mov    -0x4(%bp),%ax
    1d91:	89 46 fe             	mov    %ax,-0x2(%bp)
    1d94:	8b 46 fe             	mov    -0x2(%bp),%ax
    1d97:	8b e5                	mov    %bp,%sp
    1d99:	5d                   	pop    %bp
    1d9a:	c2 0a 00             	ret    $0xa
    1d9d:	ff 55 8b             	call   *-0x75(%di)
    1da0:	ec                   	in     (%dx),%al
    1da1:	2b 26 a0 10          	sub    0x10a0,%sp
    1da5:	83 7e 04 01          	cmpw   $0x1,0x4(%bp)
    1da9:	76 07                	jbe    0x1db2
    1dab:	c7 46 fe 01 80       	movw   $0x8001,-0x2(%bp)
    1db0:	eb 4b                	jmp    0x1dfd
    1db2:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1db7:	8b 46 04             	mov    0x4(%bp),%ax
    1dba:	3b 06 30 02          	cmp    0x230,%ax
    1dbe:	74 3d                	je     0x1dfd
    1dc0:	8b 1e 30 02          	mov    0x230,%bx
    1dc4:	e4 42                	in     $0x42,%al
    1dc6:	88 87 32 02          	mov    %al,0x232(%bx)
    1dca:	e4 4a                	in     $0x4a,%al
    1dcc:	88 46 fd             	mov    %al,-0x3(%bp)
    1dcf:	8a 46 fd             	mov    -0x3(%bp),%al
    1dd2:	24 9b                	and    $0x9b,%al
    1dd4:	8a 5e 04             	mov    0x4(%bp),%bl
    1dd7:	80 e3 01             	and    $0x1,%bl
    1dda:	b1 06                	mov    $0x6,%cl
    1ddc:	d2 e3                	shl    %cl,%bl
    1dde:	0a c3                	or     %bl,%al
    1de0:	0c 04                	or     $0x4,%al
    1de2:	e6 4a                	out    %al,$0x4a
    1de4:	e8 cc 02             	call   0x20b3
    1de7:	e8 c9 02             	call   0x20b3
    1dea:	e8 c6 02             	call   0x20b3
    1ded:	e8 c3 02             	call   0x20b3
    1df0:	8b 5e 04             	mov    0x4(%bp),%bx
    1df3:	8a 87 32 02          	mov    0x232(%bx),%al
    1df7:	e6 42                	out    %al,$0x42
    1df9:	89 1e 30 02          	mov    %bx,0x230
    1dfd:	8b 46 fe             	mov    -0x2(%bp),%ax
    1e00:	8b e5                	mov    %bp,%sp
    1e02:	5d                   	pop    %bp
    1e03:	c2 02 00             	ret    $0x2
    1e06:	55                   	push   %bp
    1e07:	8b ec                	mov    %sp,%bp
    1e09:	2b 26 a2 10          	sub    0x10a2,%sp
    1e0d:	83 7e 04 02          	cmpw   $0x2,0x4(%bp)
    1e11:	73 1f                	jae    0x1e32
    1e13:	e4 4a                	in     $0x4a,%al
    1e15:	24 fb                	and    $0xfb,%al
    1e17:	88 46 ff             	mov    %al,-0x1(%bp)
    1e1a:	8a 46 ff             	mov    -0x1(%bp),%al
    1e1d:	e6 4a                	out    %al,$0x4a
    1e1f:	e8 91 02             	call   0x20b3
    1e22:	c7 06 30 02 02 00    	movw   $0x2,0x230
    1e28:	8a 46 ff             	mov    -0x1(%bp),%al
    1e2b:	0c 20                	or     $0x20,%al
    1e2d:	e6 4a                	out    %al,$0x4a
    1e2f:	e8 81 02             	call   0x20b3
    1e32:	8b e5                	mov    %bp,%sp
    1e34:	5d                   	pop    %bp
    1e35:	c2 02 00             	ret    $0x2
    1e38:	55                   	push   %bp
    1e39:	8b ec                	mov    %sp,%bp
    1e3b:	2b 26 a4 10          	sub    0x10a4,%sp
    1e3f:	e4 40                	in     $0x40,%al
    1e41:	88 46 fd             	mov    %al,-0x3(%bp)
    1e44:	8a 46 fd             	mov    -0x3(%bp),%al
    1e47:	24 01                	and    $0x1,%al
    1e49:	0a c0                	or     %al,%al
    1e4b:	75 f2                	jne    0x1e3f
    1e4d:	8a 46 fd             	mov    -0x3(%bp),%al
    1e50:	24 80                	and    $0x80,%al
    1e52:	0a c0                	or     %al,%al
    1e54:	75 07                	jne    0x1e5d
    1e56:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1e5b:	eb 05                	jmp    0x1e62
    1e5d:	c7 46 fe 02 80       	movw   $0x8002,-0x2(%bp)
    1e62:	8b 46 fe             	mov    -0x2(%bp),%ax
    1e65:	8b e5                	mov    %bp,%sp
    1e67:	5d                   	pop    %bp
    1e68:	c3                   	ret    
    1e69:	55                   	push   %bp
    1e6a:	8b ec                	mov    %sp,%bp
    1e6c:	2b 26 a6 10          	sub    0x10a6,%sp
    1e70:	e8 c5 ff             	call   0x1e38
    1e73:	89 46 fc             	mov    %ax,-0x4(%bp)
    1e76:	83 7e fc 00          	cmpw   $0x0,-0x4(%bp)
    1e7a:	74 08                	je     0x1e84
    1e7c:	8b 46 fc             	mov    -0x4(%bp),%ax
    1e7f:	89 46 fe             	mov    %ax,-0x2(%bp)
    1e82:	eb 50                	jmp    0x1ed4
    1e84:	e4 42                	in     $0x42,%al
    1e86:	32 e4                	xor    %ah,%ah
    1e88:	3b 46 04             	cmp    0x4(%bp),%ax
    1e8b:	75 07                	jne    0x1e94
    1e8d:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1e92:	eb 40                	jmp    0x1ed4
    1e94:	8a 46 04             	mov    0x4(%bp),%al
    1e97:	e6 46                	out    %al,$0x46
    1e99:	b0 1b                	mov    $0x1b,%al
    1e9b:	e6 40                	out    %al,$0x40
    1e9d:	e8 1e 02             	call   0x20be
    1ea0:	80 3e 4d 10 00       	cmpb   $0x0,0x104d
    1ea5:	76 03                	jbe    0x1eaa
    1ea7:	e8 09 02             	call   0x20b3
    1eaa:	e4 40                	in     $0x40,%al
    1eac:	88 46 fb             	mov    %al,-0x5(%bp)
    1eaf:	8a 46 fb             	mov    -0x5(%bp),%al
    1eb2:	24 10                	and    $0x10,%al
    1eb4:	0a c0                	or     %al,%al
    1eb6:	74 07                	je     0x1ebf
    1eb8:	c7 46 fe 06 80       	movw   $0x8006,-0x2(%bp)
    1ebd:	eb 15                	jmp    0x1ed4
    1ebf:	8a 46 fb             	mov    -0x5(%bp),%al
    1ec2:	24 08                	and    $0x8,%al
    1ec4:	0a c0                	or     %al,%al
    1ec6:	74 07                	je     0x1ecf
    1ec8:	c7 46 fe 04 80       	movw   $0x8004,-0x2(%bp)
    1ecd:	eb 05                	jmp    0x1ed4
    1ecf:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1ed4:	8b 46 fe             	mov    -0x2(%bp),%ax
    1ed7:	8b e5                	mov    %bp,%sp
    1ed9:	5d                   	pop    %bp
    1eda:	c2 02 00             	ret    $0x2
    1edd:	55                   	push   %bp
    1ede:	8b ec                	mov    %sp,%bp
    1ee0:	2b 26 a8 10          	sub    0x10a8,%sp
    1ee4:	e8 d7 01             	call   0x20be
    1ee7:	b0 03                	mov    $0x3,%al
    1ee9:	e6 40                	out    %al,$0x40
    1eeb:	e8 d0 01             	call   0x20be
    1eee:	b0 00                	mov    $0x0,%al
    1ef0:	e6 42                	out    %al,$0x42
    1ef2:	e4 40                	in     $0x40,%al
    1ef4:	88 46 fd             	mov    %al,-0x3(%bp)
    1ef7:	8a 46 fd             	mov    -0x3(%bp),%al
    1efa:	24 9d                	and    $0x9d,%al
    1efc:	3c 04                	cmp    $0x4,%al
    1efe:	74 07                	je     0x1f07
    1f00:	c7 46 fe 06 80       	movw   $0x8006,-0x2(%bp)
    1f05:	eb 05                	jmp    0x1f0c
    1f07:	c7 46 fe 00 00       	movw   $0x0,-0x2(%bp)
    1f0c:	8b 46 fe             	mov    -0x2(%bp),%ax
    1f0f:	8b e5                	mov    %bp,%sp
    1f11:	5d                   	pop    %bp
    1f12:	c3                   	ret    
    1f13:	55                   	push   %bp
    1f14:	8b ec                	mov    %sp,%bp
    1f16:	2b 26 aa 10          	sub    0x10aa,%sp
    1f1a:	e8 4d f4             	call   0x136a
    1f1d:	a2 46 02             	mov    %al,0x246
    1f20:	c7 06 30 02 02 00    	movw   $0x2,0x230
    1f26:	c6 06 32 02 00       	movb   $0x0,0x232
    1f2b:	c6 06 33 02 00       	movb   $0x0,0x233
    1f30:	80 3e 0a 00 00       	cmpb   $0x0,0xa
    1f35:	74 03                	je     0x1f3a
    1f37:	e9 8b 00             	jmp    0x1fc5
    1f3a:	80 a3 4a 00 9b       	andb   $0x9b,0x4a(%bp,%di)
    1f3f:	e8 9b ff             	call   0x1edd
    1f42:	89 46 fc             	mov    %ax,-0x4(%bp)
    1f45:	e4 40                	in     $0x40,%al
    1f47:	24 04                	and    $0x4,%al
    1f49:	3c 04                	cmp    $0x4,%al
    1f4b:	75 42                	jne    0x1f8f
    1f4d:	b0 01                	mov    $0x1,%al
    1f4f:	88 46 ff             	mov    %al,-0x1(%bp)
    1f52:	b0 43                	mov    $0x43,%al
    1f54:	e6 40                	out    %al,$0x40
    1f56:	e8 65 01             	call   0x20be
    1f59:	8a 46 ff             	mov    -0x1(%bp),%al
    1f5c:	3c 46                	cmp    $0x46,%al
    1f5e:	74 04                	je     0x1f64
    1f60:	fe c0                	inc    %al
    1f62:	eb eb                	jmp    0x1f4f
    1f64:	b0 01                	mov    $0x1,%al
    1f66:	88 46 ff             	mov    %al,-0x1(%bp)
    1f69:	b0 63                	mov    $0x63,%al
    1f6b:	e6 40                	out    %al,$0x40
    1f6d:	e8 4e 01             	call   0x20be
    1f70:	8a 46 ff             	mov    -0x1(%bp),%al
    1f73:	3c 45                	cmp    $0x45,%al
    1f75:	74 04                	je     0x1f7b
    1f77:	fe c0                	inc    %al
    1f79:	eb eb                	jmp    0x1f66
    1f7b:	e4 40                	in     $0x40,%al
    1f7d:	24 04                	and    $0x4,%al
    1f7f:	3c 04                	cmp    $0x4,%al
    1f81:	75 07                	jne    0x1f8a
    1f83:	c6 06 4d 10 00       	movb   $0x0,0x104d
    1f88:	eb 05                	jmp    0x1f8f
    1f8a:	c6 06 4d 10 02       	movb   $0x2,0x104d
    1f8f:	e8 4b ff             	call   0x1edd
    1f92:	89 46 fc             	mov    %ax,-0x4(%bp)
    1f95:	c6 06 4e 10 01       	movb   $0x1,0x104e
    1f9a:	e4 4a                	in     $0x4a,%al
    1f9c:	24 9b                	and    $0x9b,%al
    1f9e:	0c 40                	or     $0x40,%al
    1fa0:	e6 4a                	out    %al,$0x4a
    1fa2:	b0 01                	mov    $0x1,%al
    1fa4:	88 46 ff             	mov    %al,-0x1(%bp)
    1fa7:	fe 46 fe             	incb   -0x2(%bp)
    1faa:	fe 4e fe             	decb   -0x2(%bp)
    1fad:	8a 46 ff             	mov    -0x1(%bp),%al
    1fb0:	3c c8                	cmp    $0xc8,%al
    1fb2:	74 04                	je     0x1fb8
    1fb4:	fe c0                	inc    %al
    1fb6:	eb ec                	jmp    0x1fa4
    1fb8:	e4 40                	in     $0x40,%al
    1fba:	24 04                	and    $0x4,%al
    1fbc:	3c 04                	cmp    $0x4,%al
    1fbe:	75 05                	jne    0x1fc5
    1fc0:	c6 06 4e 10 02       	movb   $0x2,0x104e
    1fc5:	8b e5                	mov    %bp,%sp
    1fc7:	5d                   	pop    %bp
    1fc8:	c3                   	ret    
    1fc9:	ff 06 33 c0          	incw   -0x3fcd
    1fcd:	8e c0                	mov    %ax,%es
    1fcf:	26 38 06 01 05       	cmp    %al,%es:0x501
    1fd4:	75 f9                	jne    0x1fcf
    1fd6:	07                   	pop    %es
    1fd7:	c3                   	ret    
    1fd8:	55                   	push   %bp
    1fd9:	8b ec                	mov    %sp,%bp
    1fdb:	8b 46 06             	mov    0x6(%bp),%ax
    1fde:	a3 36 02             	mov    %ax,0x236
    1fe1:	8b 46 08             	mov    0x8(%bp),%ax
    1fe4:	a3 38 02             	mov    %ax,0x238
    1fe7:	8b 46 0c             	mov    0xc(%bp),%ax
    1fea:	a3 3c 02             	mov    %ax,0x23c
    1fed:	8b 46 0a             	mov    0xa(%bp),%ax
    1ff0:	a3 3a 02             	mov    %ax,0x23a
    1ff3:	8b 46 04             	mov    0x4(%bp),%ax
    1ff6:	d0 e0                	shl    %al
    1ff8:	24 02                	and    $0x2,%al
    1ffa:	0c 88                	or     $0x88,%al
    1ffc:	a2 3e 02             	mov    %al,0x23e
    1fff:	5d                   	pop    %bp
    2000:	80 3e 46 02 00       	cmpb   $0x0,0x246
    2005:	75 03                	jne    0x200a
    2007:	e9 1c 00             	jmp    0x2026
    200a:	8c da                	mov    %ds,%dx
    200c:	33 c0                	xor    %ax,%ax
    200e:	8e d8                	mov    %ax,%ds
    2010:	bb 00 05             	mov    $0x500,%bx
    2013:	8c 4f 04             	mov    %cs,0x4(%bx)
    2016:	c7 47 02 c9 0f       	movw   $0xfc9,0x2(%bx)
    201b:	c7 07 03 ee          	movw   $0xee03,(%bx)
    201f:	8e da                	mov    %dx,%ds
    2021:	e6 70                	out    %al,$0x70
    2023:	c2 0a 00             	ret    $0xa
    2026:	e8 95 00             	call   0x20be
    2029:	e8 27 00             	call   0x2053
    202c:	e8 8f 00             	call   0x20be
    202f:	24 dc                	and    $0xdc,%al
    2031:	75 13                	jne    0x2046
    2033:	b8 00 02             	mov    $0x200,%ax
    2036:	01 06 36 02          	add    %ax,0x236
    203a:	ff 0e 3a 02          	decw   0x23a
    203e:	74 06                	je     0x2046
    2040:	ff 06 3c 02          	incw   0x23c
    2044:	eb e0                	jmp    0x2026
    2046:	06                   	push   %es
    2047:	33 c0                	xor    %ax,%ax
    2049:	8e c0                	mov    %ax,%es
    204b:	26 a2 01 05          	mov    %al,%es:0x501
    204f:	07                   	pop    %es
    2050:	c2 0a 00             	ret    $0xa
    2053:	fa                   	cli    
    2054:	33 c0                	xor    %ax,%ax
    2056:	e6 70                	out    %al,$0x70
    2058:	b8 93 0f             	mov    $0xf93,%ax
    205b:	a3 40 02             	mov    %ax,0x240
    205e:	e4 02                	in     $0x2,%al
    2060:	a2 44 02             	mov    %al,0x244
    2063:	b0 ef                	mov    $0xef,%al
    2065:	e6 02                	out    %al,$0x2
    2067:	a0 3c 02             	mov    0x23c,%al
    206a:	e6 44                	out    %al,$0x44
    206c:	8b 36 36 02          	mov    0x236,%si
    2070:	8b fe                	mov    %si,%di
    2072:	fc                   	cld    
    2073:	a0 3e 02             	mov    0x23e,%al
    2076:	8c 06 42 02          	mov    %es,0x242
    207a:	8c db                	mov    %ds,%bx
    207c:	8b 0e 38 02          	mov    0x238,%cx
    2080:	8e c1                	mov    %cx,%es
    2082:	8e d9                	mov    %cx,%ds
    2084:	b9 00 02             	mov    $0x200,%cx
    2087:	ba 46 00             	mov    $0x46,%dx
    208a:	e6 40                	out    %al,$0x40
    208c:	fb                   	sti    
    208d:	90                   	nop
    208e:	9b                   	fwait
    208f:	ec                   	in     (%dx),%al
    2090:	aa                   	stos   %al,%es:(%di)
    2091:	e2 fb                	loop   0x208e
    2093:	fa                   	cli    
    2094:	8e db                	mov    %bx,%ds
    2096:	a1 42 02             	mov    0x242,%ax
    2099:	8e c0                	mov    %ax,%es
    209b:	e4 40                	in     $0x40,%al
    209d:	b0 20                	mov    $0x20,%al
    209f:	e6 00                	out    %al,$0x0
    20a1:	a0 44 02             	mov    0x244,%al
    20a4:	e6 02                	out    %al,$0x2
    20a6:	b0 02                	mov    $0x2,%al
    20a8:	e6 70                	out    %al,$0x70
    20aa:	33 c0                	xor    %ax,%ax
    20ac:	a3 40 02             	mov    %ax,0x240
    20af:	fb                   	sti    
    20b0:	90                   	nop
    20b1:	90                   	nop
    20b2:	c3                   	ret    
    20b3:	bb 5a 00             	mov    $0x5a,%bx
    20b6:	b1 c8                	mov    $0xc8,%cl
    20b8:	d3 e1                	shl    %cl,%cx
    20ba:	4b                   	dec    %bx
    20bb:	75 f9                	jne    0x20b6
    20bd:	c3                   	ret    
    20be:	b1 14                	mov    $0x14,%cl
    20c0:	d3 e1                	shl    %cl,%cx
    20c2:	e4 40                	in     $0x40,%al
    20c4:	a8 01                	test   $0x1,%al
    20c6:	75 fa                	jne    0x20c2
    20c8:	c3                   	ret    
    20c9:	d1 e0                	shl    %ax
    20cb:	00 f0                	add    %dh,%al
    20cd:	36 e2 00             	ss loop 0x20d0
    20d0:	30 23                	xor    %ah,(%bp,%di)
    20d2:	8b 04                	mov    (%si),%ax
    20d4:	e3 81                	jcxz   0x2057
    20d6:	06                   	push   %es
    20d7:	a3 81 04             	mov    %ax,0x481
    20da:	d1 30                	shlw   (%bx,%si)
    20dc:	48                   	dec    %ax
    20dd:	88 21                	mov    %ah,(%bx,%di)
    20df:	89 48 30             	mov    %cx,0x30(%bx,%si)
    20e2:	40                   	inc    %ax
    20e3:	80 00 71             	addb   $0x71,(%bx,%si)
    20e6:	30 00                	xor    %al,(%bx,%si)
    20e8:	02 e3                	add    %bl,%ah
    20ea:	86 04                	xchg   %al,(%si)
    20ec:	03 8b 04 02          	add    0x204(%bp,%di),%cx
    20f0:	90                   	nop
    20f1:	08 00                	or     %al,(%bx,%si)
    20f3:	ce                   	into   
    20f4:	60                   	pusha  
    20f5:	00 08                	add    %cl,(%bx,%si)
    20f7:	30 46 91             	xor    %al,-0x6f(%bp)
    20fa:	20 04                	and    %al,(%si)
    20fc:	00 91 20 00          	add    %dl,0x20(%bx,%di)
    2100:	00 e0                	add    %ah,%al
    2102:	38 a0 3c a8          	cmp    %ah,-0x57c4(%bx,%si)
    2106:	40                   	inc    %ax
    2107:	02 20                	add    (%bx,%si),%ah
    2109:	48                   	dec    %ax
    210a:	08 be fd 48          	or     %bh,0x48fd(%bp)
    210e:	be f8 68             	mov    $0x68f8,%si
    2111:	be f5 88             	mov    $0x88f5,%si
    2114:	be f2 e8             	mov    $0xe8f2,%si
    2117:	be ef 88             	mov    $0x88ef,%si
    211a:	20 c9                	and    %cl,%cl
    211c:	58                   	pop    %ax
    211d:	55                   	push   %bp
    211e:	8b ec                	mov    %sp,%bp
    2120:	52                   	push   %dx
    2121:	51                   	push   %cx
    2122:	53                   	push   %bx
    2123:	56                   	push   %si
    2124:	57                   	push   %di
    2125:	9c                   	pushf  
    2126:	fc                   	cld    
    2127:	8b 76 02             	mov    0x2(%bp),%si
    212a:	ff e0                	jmp    *%ax
    212c:	c6 06 cf 02 01       	movb   $0x1,0x2cf
    2131:	9d                   	popf   
    2132:	5f                   	pop    %di
    2133:	5e                   	pop    %si
    2134:	5b                   	pop    %bx
    2135:	59                   	pop    %cx
    2136:	5a                   	pop    %dx
    2137:	5d                   	pop    %bp
    2138:	c3                   	ret    
    2139:	e8 e0 ff             	call   0x211c
    213c:	b6 00                	mov    $0x0,%dh
    213e:	e9 05 00             	jmp    0x2146
    2141:	e8 d8 ff             	call   0x211c
    2144:	b6 80                	mov    $0x80,%dh
    2146:	8d 06 88 02          	lea    0x288,%ax
    214a:	8b d8                	mov    %ax,%bx
    214c:	8d 2e 7f 02          	lea    0x27f,%bp
    2150:	80 7f 01 00          	cmpb   $0x0,0x1(%bx)
    2154:	74 db                	je     0x2131
    2156:	32 77 00             	xor    0x0(%bx),%dh
    2159:	32 36 7f 02          	xor    0x27f,%dh
    215d:	8a 47 01             	mov    0x1(%bx),%al
    2160:	04 80                	add    $0x80,%al
    2162:	98                   	cbtw   
    2163:	8b c8                	mov    %ax,%cx
    2165:	a0 80 02             	mov    0x280,%al
    2168:	04 80                	add    $0x80,%al
    216a:	98                   	cbtw   
    216b:	2b c1                	sub    %cx,%ax
    216d:	79 0c                	jns    0x217b
    216f:	87 dd                	xchg   %bx,%bp
    2171:	28 06 80 02          	sub    %al,0x280
    2175:	30 36 7f 02          	xor    %dh,0x27f
    2179:	f7 d8                	neg    %ax
    217b:	b9 07 00             	mov    $0x7,%cx
    217e:	8d 76 02             	lea    0x2(%bp),%si
    2181:	8d 3e b9 02          	lea    0x2b9,%di
    2185:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    2187:	3d 08 00             	cmp    $0x8,%ax
    218a:	7d 67                	jge    0x21f3
    218c:	b9 07 00             	mov    $0x7,%cx
    218f:	b2 64                	mov    $0x64,%dl
    2191:	8b f1                	mov    %cx,%si
    2193:	8b f9                	mov    %cx,%di
    2195:	03 f8                	add    %ax,%di
    2197:	83 ff 09             	cmp    $0x9,%di
    219a:	7f 29                	jg     0x21c5
    219c:	8a 60 01             	mov    0x1(%bx,%si),%ah
    219f:	8a 85 b8 02          	mov    0x2b8(%di),%al
    21a3:	80 fe 00             	cmp    $0x0,%dh
    21a6:	75 0f                	jne    0x21b7
    21a8:	02 c4                	add    %ah,%al
    21aa:	3a c2                	cmp    %dl,%al
    21ac:	72 13                	jb     0x21c1
    21ae:	2a c2                	sub    %dl,%al
    21b0:	fe 85 b7 02          	incb   0x2b7(%di)
    21b4:	e9 0a 00             	jmp    0x21c1
    21b7:	2a c4                	sub    %ah,%al
    21b9:	79 06                	jns    0x21c1
    21bb:	02 c2                	add    %dl,%al
    21bd:	fe 8d b7 02          	decb   0x2b7(%di)
    21c1:	88 85 b8 02          	mov    %al,0x2b8(%di)
    21c5:	4e                   	dec    %si
    21c6:	4f                   	dec    %di
    21c7:	e2 ce                	loop   0x2197
    21c9:	38 95 b8 02          	cmp    %dl,0x2b8(%di)
    21cd:	7c 0b                	jl     0x21da
    21cf:	28 95 b8 02          	sub    %dl,0x2b8(%di)
    21d3:	4f                   	dec    %di
    21d4:	fe 85 b8 02          	incb   0x2b8(%di)
    21d8:	eb ef                	jmp    0x21c9
    21da:	80 3e b8 02 00       	cmpb   $0x0,0x2b8
    21df:	7c 15                	jl     0x21f6
    21e1:	80 bd b8 02 00       	cmpb   $0x0,0x2b8(%di)
    21e6:	7d 29                	jge    0x2211
    21e8:	00 95 b8 02          	add    %dl,0x2b8(%di)
    21ec:	4f                   	dec    %di
    21ed:	fe 8d b8 02          	decb   0x2b8(%di)
    21f1:	78 f5                	js     0x21e8
    21f3:	e9 1b 00             	jmp    0x2211
    21f6:	b9 07 00             	mov    $0x7,%cx
    21f9:	8d 3e bf 02          	lea    0x2bf,%di
    21fd:	8b f7                	mov    %di,%si
    21ff:	fd                   	std    
    2200:	ac                   	lods   %ds:(%si),%al
    2201:	f6 d8                	neg    %al
    2203:	79 04                	jns    0x2209
    2205:	02 c2                	add    %dl,%al
    2207:	fe 04                	incb   (%si)
    2209:	aa                   	stos   %al,%es:(%di)
    220a:	e2 f4                	loop   0x2200
    220c:	80 36 7f 02 80       	xorb   $0x80,0x27f
    2211:	e9 bb 03             	jmp    0x25cf
    2214:	e9 8a 03             	jmp    0x25a1
    2217:	e9 78 03             	jmp    0x2592
    221a:	e9 14 ff             	jmp    0x2131
    221d:	e8 fc fe             	call   0x211c
    2220:	8d 36 88 02          	lea    0x288,%si
    2224:	8b c6                	mov    %si,%ax
    2226:	80 3e 80 02 00       	cmpb   $0x0,0x280
    222b:	74 ea                	je     0x2217
    222d:	ac                   	lods   %ds:(%si),%al
    222e:	30 06 7f 02          	xor    %al,0x27f
    2232:	ac                   	lods   %ds:(%si),%al
    2233:	b4 80                	mov    $0x80,%ah
    2235:	02 c4                	add    %ah,%al
    2237:	00 26 80 02          	add    %ah,0x280
    223b:	00 06 80 02          	add    %al,0x280
    223f:	70 45                	jo     0x2286
    2241:	fe 06 80 02          	incb   0x280
    2245:	70 3f                	jo     0x2286
    2247:	00 26 80 02          	add    %ah,0x280
    224b:	8b ee                	mov    %si,%bp
    224d:	4d                   	dec    %bp
    224e:	b6 64                	mov    $0x64,%dh
    2250:	bb 07 00             	mov    $0x7,%bx
    2253:	b9 09 00             	mov    $0x9,%cx
    2256:	2b cb                	sub    %bx,%cx
    2258:	8a 97 80 02          	mov    0x280(%bx),%dl
    225c:	8b f1                	mov    %cx,%si
    225e:	8a 02                	mov    (%bp,%si),%al
    2260:	f6 e2                	mul    %dl
    2262:	f6 f6                	div    %dh
    2264:	03 80 b7 02          	add    0x2b7(%bx,%si),%ax
    2268:	3a e6                	cmp    %dh,%ah
    226a:	72 04                	jb     0x2270
    226c:	2a e6                	sub    %dh,%ah
    226e:	fe c0                	inc    %al
    2270:	3a c6                	cmp    %dh,%al
    2272:	72 06                	jb     0x227a
    2274:	2a c6                	sub    %dh,%al
    2276:	fe 80 b6 02          	incb   0x2b6(%bx,%si)
    227a:	89 80 b7 02          	mov    %ax,0x2b7(%bx,%si)
    227e:	e2 dc                	loop   0x225c
    2280:	4b                   	dec    %bx
    2281:	7f d0                	jg     0x2253
    2283:	e9 49 03             	jmp    0x25cf
    2286:	72 8f                	jb     0x2217
    2288:	eb 8a                	jmp    0x2214
    228a:	e8 8f fe             	call   0x211c
    228d:	8d 36 88 02          	lea    0x288,%si
    2291:	8b c6                	mov    %si,%ax
    2293:	80 3e 80 02 00       	cmpb   $0x0,0x280
    2298:	75 03                	jne    0x229d
    229a:	e9 94 fe             	jmp    0x2131
    229d:	ac                   	lods   %ds:(%si),%al
    229e:	30 06 7f 02          	xor    %al,0x27f
    22a2:	b4 80                	mov    $0x80,%ah
    22a4:	ac                   	lods   %ds:(%si),%al
    22a5:	3c 00                	cmp    $0x0,%al
    22a7:	75 03                	jne    0x22ac
    22a9:	e9 f5 02             	jmp    0x25a1
    22ac:	02 c4                	add    %ah,%al
    22ae:	00 26 80 02          	add    %ah,0x280
    22b2:	28 06 80 02          	sub    %al,0x280
    22b6:	70 5d                	jo     0x2315
    22b8:	00 26 80 02          	add    %ah,0x280
    22bc:	8b ee                	mov    %si,%bp
    22be:	4d                   	dec    %bp
    22bf:	ac                   	lods   %ds:(%si),%al
    22c0:	b3 64                	mov    $0x64,%bl
    22c2:	f6 e3                	mul    %bl
    22c4:	8b d8                	mov    %ax,%bx
    22c6:	ac                   	lods   %ds:(%si),%al
    22c7:	98                   	cbtw   
    22c8:	03 d8                	add    %ax,%bx
    22ca:	43                   	inc    %bx
    22cb:	b0 64                	mov    $0x64,%al
    22cd:	f6 26 81 02          	mulb   0x281
    22d1:	02 06 82 02          	add    0x282,%al
    22d5:	73 02                	jae    0x22d9
    22d7:	fe c4                	inc    %ah
    22d9:	8d 36 81 02          	lea    0x281,%si
    22dd:	8d 3e ad 02          	lea    0x2ad,%di
    22e1:	b9 07 00             	mov    $0x7,%cx
    22e4:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    22e6:	be 01 00             	mov    $0x1,%si
    22e9:	ba 00 00             	mov    $0x0,%dx
    22ec:	3d c8 00             	cmp    $0xc8,%ax
    22ef:	72 04                	jb     0x22f5
    22f1:	3b c3                	cmp    %bx,%ax
    22f3:	77 23                	ja     0x2318
    22f5:	46                   	inc    %si
    22f6:	83 fe 0a             	cmp    $0xa,%si
    22f9:	7d 17                	jge    0x2312
    22fb:	ba 64 00             	mov    $0x64,%dx
    22fe:	f7 e2                	mul    %dx
    2300:	02 84 ad 02          	add    0x2ad(%si),%al
    2304:	73 05                	jae    0x230b
    2306:	fe c4                	inc    %ah
    2308:	75 01                	jne    0x230b
    230a:	42                   	inc    %dx
    230b:	83 fa 00             	cmp    $0x0,%dx
    230e:	75 08                	jne    0x2318
    2310:	eb da                	jmp    0x22ec
    2312:	e9 69 00             	jmp    0x237e
    2315:	e9 69 00             	jmp    0x2381
    2318:	f7 f3                	div    %bx
    231a:	00 84 b8 02          	add    %al,0x2b8(%si)
    231e:	8b fe                	mov    %si,%di
    2320:	b6 64                	mov    $0x64,%dh
    2322:	38 b5 b8 02          	cmp    %dh,0x2b8(%di)
    2326:	72 0b                	jb     0x2333
    2328:	28 b5 b8 02          	sub    %dh,0x2b8(%di)
    232c:	4f                   	dec    %di
    232d:	fe 85 b8 02          	incb   0x2b8(%di)
    2331:	eb ef                	jmp    0x2322
    2333:	56                   	push   %si
    2334:	8a d0                	mov    %al,%dl
    2336:	b9 07 00             	mov    $0x7,%cx
    2339:	8b f9                	mov    %cx,%di
    233b:	03 fe                	add    %si,%di
    233d:	4f                   	dec    %di
    233e:	83 ff 0b             	cmp    $0xb,%di
    2341:	7f 24                	jg     0x2367
    2343:	8b f1                	mov    %cx,%si
    2345:	8a 02                	mov    (%bp,%si),%al
    2347:	f6 e2                	mul    %dl
    2349:	f6 f6                	div    %dh
    234b:	28 a5 ac 02          	sub    %ah,0x2ac(%di)
    234f:	79 06                	jns    0x2357
    2351:	fe c0                	inc    %al
    2353:	00 b5 ac 02          	add    %dh,0x2ac(%di)
    2357:	28 85 ab 02          	sub    %al,0x2ab(%di)
    235b:	73 08                	jae    0x2365
    235d:	fe 8d aa 02          	decb   0x2aa(%di)
    2361:	00 b5 ab 02          	add    %dh,0x2ab(%di)
    2365:	78 f6                	js     0x235d
    2367:	e2 d4                	loop   0x233d
    2369:	5e                   	pop    %si
    236a:	8a 84 ab 02          	mov    0x2ab(%si),%al
    236e:	f6 e6                	mul    %dh
    2370:	02 84 ac 02          	add    0x2ac(%si),%al
    2374:	73 02                	jae    0x2378
    2376:	fe c4                	inc    %ah
    2378:	ba 00 00             	mov    $0x0,%dx
    237b:	e9 78 ff             	jmp    0x22f6
    237e:	e9 4e 02             	jmp    0x25cf
    2381:	72 03                	jb     0x2386
    2383:	e9 0c 02             	jmp    0x2592
    2386:	e9 18 02             	jmp    0x25a1
    2389:	e8 90 fd             	call   0x211c
    238c:	8d 36 88 02          	lea    0x288,%si
    2390:	8b c6                	mov    %si,%ax
    2392:	8d 3e 7f 02          	lea    0x27f,%di
    2396:	e9 0d 00             	jmp    0x23a6
    2399:	e8 80 fd             	call   0x211c
    239c:	8d 3e 88 02          	lea    0x288,%di
    23a0:	8b c7                	mov    %di,%ax
    23a2:	8d 36 7f 02          	lea    0x27f,%si
    23a6:	b9 09 00             	mov    $0x9,%cx
    23a9:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    23ab:	e9 83 fd             	jmp    0x2131
    23ae:	fc                   	cld    
    23af:	8d 36 7f 02          	lea    0x27f,%si
    23b3:	8d 3e 7f 02          	lea    0x27f,%di
    23b7:	ad                   	lods   %ds:(%si),%ax
    23b8:	87 06 88 02          	xchg   %ax,0x288
    23bc:	ab                   	stos   %ax,%es:(%di)
    23bd:	ad                   	lods   %ds:(%si),%ax
    23be:	87 06 8a 02          	xchg   %ax,0x28a
    23c2:	ab                   	stos   %ax,%es:(%di)
    23c3:	ad                   	lods   %ds:(%si),%ax
    23c4:	87 06 8c 02          	xchg   %ax,0x28c
    23c8:	ab                   	stos   %ax,%es:(%di)
    23c9:	ad                   	lods   %ds:(%si),%ax
    23ca:	87 06 8e 02          	xchg   %ax,0x28e
    23ce:	ab                   	stos   %ax,%es:(%di)
    23cf:	ac                   	lods   %ds:(%si),%al
    23d0:	86 06 90 02          	xchg   %al,0x290
    23d4:	aa                   	stos   %al,%es:(%di)
    23d5:	c3                   	ret    
    23d6:	e8 43 fd             	call   0x211c
    23d9:	a0 ba 02             	mov    0x2ba,%al
    23dc:	3c 00                	cmp    $0x0,%al
    23de:	74 02                	je     0x23e2
    23e0:	b0 80                	mov    $0x80,%al
    23e2:	a2 7f 02             	mov    %al,0x27f
    23e5:	a0 b9 02             	mov    0x2b9,%al
    23e8:	3c 0f                	cmp    $0xf,%al
    23ea:	75 05                	jne    0x23f1
    23ec:	32 c0                	xor    %al,%al
    23ee:	a2 b9 02             	mov    %al,0x2b9
    23f1:	d0 e8                	shr    %al
    23f3:	f6 d8                	neg    %al
    23f5:	04 84                	add    $0x84,%al
    23f7:	a2 80 02             	mov    %al,0x280
    23fa:	8d 36 bb 02          	lea    0x2bb,%si
    23fe:	b9 0a 00             	mov    $0xa,%cx
    2401:	8b fe                	mov    %si,%di
    2403:	32 c0                	xor    %al,%al
    2405:	80 3d 0f             	cmpb   $0xf,(%di)
    2408:	75 03                	jne    0x240d
    240a:	aa                   	stos   %al,%es:(%di)
    240b:	e2 f8                	loop   0x2405
    240d:	b9 05 00             	mov    $0x5,%cx
    2410:	f6 06 b9 02 01       	testb  $0x1,0x2b9
    2415:	74 0c                	je     0x2423
    2417:	41                   	inc    %cx
    2418:	4e                   	dec    %si
    2419:	c6 06 ba 02 00       	movb   $0x0,0x2ba
    241e:	c6 06 c5 02 00       	movb   $0x0,0x2c5
    2423:	8d 3e b9 02          	lea    0x2b9,%di
    2427:	ad                   	lods   %ds:(%si),%ax
    2428:	86 c4                	xchg   %al,%ah
    242a:	d5 0a                	aad    $0xa
    242c:	aa                   	stos   %al,%es:(%di)
    242d:	e2 f8                	loop   0x2427
    242f:	b0 00                	mov    $0x0,%al
    2431:	b9 07 00             	mov    $0x7,%cx
    2434:	f3 aa                	rep stos %al,%es:(%di)
    2436:	e9 96 01             	jmp    0x25cf
    2439:	e8 e0 fc             	call   0x211c
    243c:	c6 06 b9 02 14       	movb   $0x14,0x2b9
    2441:	a0 7f 02             	mov    0x27f,%al
    2444:	a2 ac 02             	mov    %al,0x2ac
    2447:	b7 00                	mov    $0x0,%bh
    2449:	b2 01                	mov    $0x1,%dl
    244b:	80 3e 81 02 0a       	cmpb   $0xa,0x281
    2450:	7c 02                	jl     0x2454
    2452:	fe c2                	inc    %dl
    2454:	a0 80 02             	mov    0x280,%al
    2457:	04 80                	add    $0x80,%al
    2459:	3c 0a                	cmp    $0xa,%al
    245b:	7d 6b                	jge    0x24c8
    245d:	3c f6                	cmp    $0xf6,%al
    245f:	7f 02                	jg     0x2463
    2461:	b0 f6                	mov    $0xf6,%al
    2463:	d0 e0                	shl    %al
    2465:	02 c2                	add    %dl,%al
    2467:	3c 00                	cmp    $0x0,%al
    2469:	7f 1d                	jg     0x2488
    246b:	f6 d8                	neg    %al
    246d:	8a 3e b9 02          	mov    0x2b9,%bh
    2471:	80 ff 0a             	cmp    $0xa,%bh
    2474:	7c 03                	jl     0x2479
    2476:	80 ef 0a             	sub    $0xa,%bh
    2479:	3a c7                	cmp    %bh,%al
    247b:	7e 05                	jle    0x2482
    247d:	c6 06 ac 02 00       	movb   $0x0,0x2ac
    2482:	fe c0                	inc    %al
    2484:	8a f8                	mov    %al,%bh
    2486:	b0 01                	mov    $0x1,%al
    2488:	3c 0a                	cmp    $0xa,%al
    248a:	7f 3c                	jg     0x24c8
    248c:	8a f0                	mov    %al,%dh
    248e:	8d 36 81 02          	lea    0x281,%si
    2492:	8a c2                	mov    %dl,%al
    2494:	02 c7                	add    %bh,%al
    2496:	fe c0                	inc    %al
    2498:	98                   	cbtw   
    2499:	8b f8                	mov    %ax,%di
    249b:	b9 0e 00             	mov    $0xe,%cx
    249e:	2b cf                	sub    %di,%cx
    24a0:	41                   	inc    %cx
    24a1:	d1 f9                	sar    %cx
    24a3:	7e 10                	jle    0x24b5
    24a5:	53                   	push   %bx
    24a6:	8d 1e b8 02          	lea    0x2b8,%bx
    24aa:	03 fb                	add    %bx,%di
    24ac:	5b                   	pop    %bx
    24ad:	ac                   	lods   %ds:(%si),%al
    24ae:	d4 0a                	aam    $0xa
    24b0:	86 c4                	xchg   %al,%ah
    24b2:	ab                   	stos   %ax,%es:(%di)
    24b3:	e2 f8                	loop   0x24ad
    24b5:	b2 00                	mov    $0x0,%dl
    24b7:	80 3e b9 02 0a       	cmpb   $0xa,0x2b9
    24bc:	72 0d                	jb     0x24cb
    24be:	80 2e b9 02 0a       	subb   $0xa,0x2b9
    24c3:	b2 01                	mov    $0x1,%dl
    24c5:	e9 03 00             	jmp    0x24cb
    24c8:	e9 a8 00             	jmp    0x2573
    24cb:	8d 36 bb 02          	lea    0x2bb,%si
    24cf:	8a c6                	mov    %dh,%al
    24d1:	02 06 b9 02          	add    0x2b9,%al
    24d5:	98                   	cbtw   
    24d6:	03 f0                	add    %ax,%si
    24d8:	81 fe c5 02          	cmp    $0x2c5,%si
    24dc:	7e 0d                	jle    0x24eb
    24de:	c6 06 b9 02 0a       	movb   $0xa,0x2b9
    24e3:	28 36 b9 02          	sub    %dh,0x2b9
    24e7:	8d 36 c5 02          	lea    0x2c5,%si
    24eb:	fd                   	std    
    24ec:	80 04 05             	addb   $0x5,(%si)
    24ef:	b3 0a                	mov    $0xa,%bl
    24f1:	38 1c                	cmp    %bl,(%si)
    24f3:	7c 03                	jl     0x24f8
    24f5:	fe 44 ff             	incb   -0x1(%si)
    24f8:	8d 3e c4 02          	lea    0x2c4,%di
    24fc:	8b ce                	mov    %si,%cx
    24fe:	81 e9 bb 02          	sub    $0x2bb,%cx
    2502:	c6 06 ba 02 00       	movb   $0x0,0x2ba
    2507:	8a 3e b9 02          	mov    0x2b9,%bh
    250b:	ac                   	lods   %ds:(%si),%al
    250c:	ac                   	lods   %ds:(%si),%al
    250d:	3a c3                	cmp    %bl,%al
    250f:	72 04                	jb     0x2515
    2511:	2a c3                	sub    %bl,%al
    2513:	fe 04                	incb   (%si)
    2515:	80 fa 00             	cmp    $0x0,%dl
    2518:	74 13                	je     0x252d
    251a:	3c 00                	cmp    $0x0,%al
    251c:	75 05                	jne    0x2523
    251e:	80 ff 00             	cmp    $0x0,%bh
    2521:	75 05                	jne    0x2528
    2523:	b2 00                	mov    $0x0,%dl
    2525:	e9 05 00             	jmp    0x252d
    2528:	fe cf                	dec    %bh
    252a:	e9 01 00             	jmp    0x252e
    252d:	aa                   	stos   %al,%es:(%di)
    252e:	e2 dc                	loop   0x250c
    2530:	80 3c 00             	cmpb   $0x0,(%si)
    2533:	74 18                	je     0x254d
    2535:	81 ff ba 02          	cmp    $0x2ba,%di
    2539:	77 0f                	ja     0x254a
    253b:	80 ff 00             	cmp    $0x0,%bh
    253e:	7e 33                	jle    0x2573
    2540:	c6 06 bb 02 01       	movb   $0x1,0x2bb
    2545:	fe cf                	dec    %bh
    2547:	e9 03 00             	jmp    0x254d
    254a:	b0 01                	mov    $0x1,%al
    254c:	aa                   	stos   %al,%es:(%di)
    254d:	80 ff 00             	cmp    $0x0,%bh
    2550:	75 02                	jne    0x2554
    2552:	b7 0f                	mov    $0xf,%bh
    2554:	88 3e b9 02          	mov    %bh,0x2b9
    2558:	8b cf                	mov    %di,%cx
    255a:	81 e9 ba 02          	sub    $0x2ba,%cx
    255e:	7e 04                	jle    0x2564
    2560:	b0 0f                	mov    $0xf,%al
    2562:	f3 aa                	rep stos %al,%es:(%di)
    2564:	a0 ac 02             	mov    0x2ac,%al
    2567:	3c 00                	cmp    $0x0,%al
    2569:	74 02                	je     0x256d
    256b:	b0 08                	mov    $0x8,%al
    256d:	a2 ba 02             	mov    %al,0x2ba
    2570:	e9 be fb             	jmp    0x2131
    2573:	b0 09                	mov    $0x9,%al
    2575:	b9 0a 00             	mov    $0xa,%cx
    2578:	8d 3e bb 02          	lea    0x2bb,%di
    257c:	f3 aa                	rep stos %al,%es:(%di)
    257e:	c6 06 b9 02 0f       	movb   $0xf,0x2b9
    2583:	a0 ac 02             	mov    0x2ac,%al
    2586:	3c 00                	cmp    $0x0,%al
    2588:	74 02                	je     0x258c
    258a:	b0 08                	mov    $0x8,%al
    258c:	a2 ba 02             	mov    %al,0x2ba
    258f:	e9 9a fb             	jmp    0x212c
    2592:	fc                   	cld    
    2593:	b0 00                	mov    $0x0,%al
    2595:	b9 09 00             	mov    $0x9,%cx
    2598:	8d 3e 7f 02          	lea    0x27f,%di
    259c:	f3 aa                	rep stos %al,%es:(%di)
    259e:	e9 1f 00             	jmp    0x25c0
    25a1:	fc                   	cld    
    25a2:	b0 63                	mov    $0x63,%al
    25a4:	b9 07 00             	mov    $0x7,%cx
    25a7:	8d 3e 81 02          	lea    0x281,%di
    25ab:	f3 aa                	rep stos %al,%es:(%di)
    25ad:	c6 06 80 02 ff       	movb   $0xff,0x280
    25b2:	c6 06 cf 02 01       	movb   $0x1,0x2cf
    25b7:	e9 06 00             	jmp    0x25c0
    25ba:	e8 5f fb             	call   0x211c
    25bd:	e9 00 00             	jmp    0x25c0
    25c0:	fc                   	cld    
    25c1:	b0 00                	mov    $0x0,%al
    25c3:	8d 3e ac 02          	lea    0x2ac,%di
    25c7:	b9 1c 00             	mov    $0x1c,%cx
    25ca:	f3 aa                	rep stos %al,%es:(%di)
    25cc:	e9 62 fb             	jmp    0x2131
    25cf:	be 00 00             	mov    $0x0,%si
    25d2:	80 06 80 02 80       	addb   $0x80,0x280
    25d7:	80 3e b8 02 00       	cmpb   $0x0,0x2b8
    25dc:	74 09                	je     0x25e7
    25de:	fe 06 80 02          	incb   0x280
    25e2:	70 bd                	jo     0x25a1
    25e4:	e9 19 00             	jmp    0x2600
    25e7:	b9 07 00             	mov    $0x7,%cx
    25ea:	46                   	inc    %si
    25eb:	80 bc b8 02 00       	cmpb   $0x0,0x2b8(%si)
    25f0:	75 04                	jne    0x25f6
    25f2:	e2 f6                	loop   0x25ea
    25f4:	eb 9c                	jmp    0x2592
    25f6:	4e                   	dec    %si
    25f7:	8b c6                	mov    %si,%ax
    25f9:	28 06 80 02          	sub    %al,0x280
    25fd:	70 93                	jo     0x2592
    25ff:	46                   	inc    %si
    2600:	b9 07 00             	mov    $0x7,%cx
    2603:	8d 3e 87 02          	lea    0x287,%di
    2607:	fd                   	std    
    2608:	03 f1                	add    %cx,%si
    260a:	b6 64                	mov    $0x64,%dh
    260c:	b0 32                	mov    $0x32,%al
    260e:	02 84 b8 02          	add    0x2b8(%si),%al
    2612:	3a c6                	cmp    %dh,%al
    2614:	72 04                	jb     0x261a
    2616:	fe 84 b7 02          	incb   0x2b7(%si)
    261a:	4e                   	dec    %si
    261b:	8a 84 b8 02          	mov    0x2b8(%si),%al
    261f:	3a c6                	cmp    %dh,%al
    2621:	72 06                	jb     0x2629
    2623:	2a c6                	sub    %dh,%al
    2625:	fe 84 b7 02          	incb   0x2b7(%si)
    2629:	aa                   	stos   %al,%es:(%di)
    262a:	e2 ee                	loop   0x261a
    262c:	80 bc b7 02 00       	cmpb   $0x0,0x2b7(%si)
    2631:	74 0c                	je     0x263f
    2633:	fe 06 80 02          	incb   0x280
    2637:	71 03                	jno    0x263c
    2639:	e9 65 ff             	jmp    0x25a1
    263c:	fe 45 01             	incb   0x1(%di)
    263f:	80 06 80 02 80       	addb   $0x80,0x280
    2644:	e9 79 ff             	jmp    0x25c0
    2647:	e8 70 ff             	call   0x25ba
    264a:	e8 cf fa             	call   0x211c
    264d:	b9 0d 00             	mov    $0xd,%cx
    2650:	80 3e 47 02 2d       	cmpb   $0x2d,0x247
    2655:	75 04                	jne    0x265b
    2657:	a2 ba 02             	mov    %al,0x2ba
    265a:	49                   	dec    %cx
    265b:	b4 00                	mov    $0x0,%ah
    265d:	8d 36 53 02          	lea    0x253,%si
    2661:	8d 3e c4 02          	lea    0x2c4,%di
    2665:	fd                   	std    
    2666:	ac                   	lods   %ds:(%si),%al
    2667:	3c 20                	cmp    $0x20,%al
    2669:	75 02                	jne    0x266d
    266b:	e2 f9                	loop   0x2666
    266d:	3c 2e                	cmp    $0x2e,%al
    266f:	75 09                	jne    0x267a
    2671:	88 26 b9 02          	mov    %ah,0x2b9
    2675:	e2 ef                	loop   0x2666
    2677:	e9 07 00             	jmp    0x2681
    267a:	fe c4                	inc    %ah
    267c:	24 0f                	and    $0xf,%al
    267e:	aa                   	stos   %al,%es:(%di)
    267f:	e2 e5                	loop   0x2666
    2681:	e9 ad fa             	jmp    0x2131
    2684:	b8 30 2e             	mov    $0x2e30,%ax
    2687:	8d 3e 47 02          	lea    0x247,%di
    268b:	fc                   	cld    
    268c:	ab                   	stos   %ax,%es:(%di)
    268d:	b8 20 20             	mov    $0x2020,%ax
    2690:	b9 08 00             	mov    $0x8,%cx
    2693:	f3 ab                	rep stos %ax,%es:(%di)
    2695:	c6 06 7d 02 00       	movb   $0x0,0x27d
    269a:	c3                   	ret    
    269b:	b8 20 20             	mov    $0x2020,%ax
    269e:	8d 3e 5b 02          	lea    0x25b,%di
    26a2:	b9 0a 00             	mov    $0xa,%cx
    26a5:	fc                   	cld    
    26a6:	f3 ab                	rep stos %ax,%es:(%di)
    26a8:	c3                   	ret    
    26a9:	e8 70 fa             	call   0x211c
    26ac:	e8 d5 ff             	call   0x2684
    26af:	a0 cf 02             	mov    0x2cf,%al
    26b2:	3c 00                	cmp    $0x0,%al
    26b4:	74 1c                	je     0x26d2
    26b6:	c6 06 47 02 45       	movb   $0x45,0x247
    26bb:	c6 06 48 02 72       	movb   $0x72,0x248
    26c0:	c6 06 49 02 72       	movb   $0x72,0x249
    26c5:	c6 06 4a 02 6f       	movb   $0x6f,0x24a
    26ca:	c6 06 4b 02 72       	movb   $0x72,0x24b
    26cf:	e9 38 00             	jmp    0x270a
    26d2:	b9 0a 00             	mov    $0xa,%cx
    26d5:	b4 0a                	mov    $0xa,%ah
    26d7:	a0 b9 02             	mov    0x2b9,%al
    26da:	3c 0a                	cmp    $0xa,%al
    26dc:	7f 02                	jg     0x26e0
    26de:	2a e0                	sub    %al,%ah
    26e0:	fc                   	cld    
    26e1:	8d 36 ba 02          	lea    0x2ba,%si
    26e5:	8d 3e 47 02          	lea    0x247,%di
    26e9:	ac                   	lods   %ds:(%si),%al
    26ea:	3c 00                	cmp    $0x0,%al
    26ec:	74 03                	je     0x26f1
    26ee:	b0 2d                	mov    $0x2d,%al
    26f0:	aa                   	stos   %al,%es:(%di)
    26f1:	80 fc 00             	cmp    $0x0,%ah
    26f4:	75 03                	jne    0x26f9
    26f6:	b0 2e                	mov    $0x2e,%al
    26f8:	aa                   	stos   %al,%es:(%di)
    26f9:	ac                   	lods   %ds:(%si),%al
    26fa:	3c 0f                	cmp    $0xf,%al
    26fc:	74 03                	je     0x2701
    26fe:	0c 30                	or     $0x30,%al
    2700:	aa                   	stos   %al,%es:(%di)
    2701:	fe cc                	dec    %ah
    2703:	75 03                	jne    0x2708
    2705:	b0 2e                	mov    $0x2e,%al
    2707:	aa                   	stos   %al,%es:(%di)
    2708:	e2 ef                	loop   0x26f9
    270a:	e9 24 fa             	jmp    0x2131
    270d:	e8 8b ff             	call   0x269b
    2710:	c6 06 59 02 20       	movb   $0x20,0x259
    2715:	c6 06 5a 02 20       	movb   $0x20,0x25a
    271a:	e8 67 ff             	call   0x2684
    271d:	e8 9a fe             	call   0x25ba
    2720:	8d 3e 7f 02          	lea    0x27f,%di
    2724:	b8 00 00             	mov    $0x0,%ax
    2727:	b9 09 00             	mov    $0x9,%cx
    272a:	fc                   	cld    
    272b:	f3 ab                	rep stos %ax,%es:(%di)
    272d:	c6 06 c8 02 00       	movb   $0x0,0x2c8
    2732:	c6 06 c9 02 00       	movb   $0x0,0x2c9
    2737:	c6 06 cb 02 00       	movb   $0x0,0x2cb
    273c:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    2741:	c6 06 cc 02 00       	movb   $0x0,0x2cc
    2746:	c7 06 7d 02 00 00    	movw   $0x0,0x27d
    274c:	c6 06 cd 02 00       	movb   $0x0,0x2cd
    2751:	c6 06 ce 02 00       	movb   $0x0,0x2ce
    2756:	c6 06 cf 02 00       	movb   $0x0,0x2cf
    275b:	c3                   	ret    
    275c:	b8 80 00             	mov    $0x80,%ax
    275f:	50                   	push   %ax
    2760:	e8 71 ec             	call   0x13d4
    2763:	8d 36 47 02          	lea    0x247,%si
    2767:	b9 20 00             	mov    $0x20,%cx
    276a:	fc                   	cld    
    276b:	ac                   	lods   %ds:(%si),%al
    276c:	80 3e c8 02 00       	cmpb   $0x0,0x2c8
    2771:	74 41                	je     0x27b4
    2773:	3c 20                	cmp    $0x20,%al
    2775:	75 30                	jne    0x27a7
    2777:	80 3e cc 02 01       	cmpb   $0x1,0x2cc
    277c:	75 05                	jne    0x2783
    277e:	b0 2b                	mov    $0x2b,%al
    2780:	e9 31 00             	jmp    0x27b4
    2783:	80 3e cc 02 02       	cmpb   $0x2,0x2cc
    2788:	75 05                	jne    0x278f
    278a:	b0 2d                	mov    $0x2d,%al
    278c:	e9 25 00             	jmp    0x27b4
    278f:	80 3e cc 02 03       	cmpb   $0x3,0x2cc
    2794:	75 05                	jne    0x279b
    2796:	b0 78                	mov    $0x78,%al
    2798:	e9 19 00             	jmp    0x27b4
    279b:	80 3e cc 02 04       	cmpb   $0x4,0x2cc
    27a0:	75 12                	jne    0x27b4
    27a2:	b0 10                	mov    $0x10,%al
    27a4:	e9 0d 00             	jmp    0x27b4
    27a7:	56                   	push   %si
    27a8:	51                   	push   %cx
    27a9:	50                   	push   %ax
    27aa:	e8 27 ec             	call   0x13d4
    27ad:	59                   	pop    %cx
    27ae:	5e                   	pop    %si
    27af:	e2 b9                	loop   0x276a
    27b1:	c3                   	ret    
    27b2:	fc                   	cld    
    27b3:	ac                   	lods   %ds:(%si),%al
    27b4:	56                   	push   %si
    27b5:	51                   	push   %cx
    27b6:	50                   	push   %ax
    27b7:	e8 1a ec             	call   0x13d4
    27ba:	59                   	pop    %cx
    27bb:	5e                   	pop    %si
    27bc:	e2 f4                	loop   0x27b2
    27be:	c3                   	ret    
    27bf:	b8 a8 00             	mov    $0xa8,%ax
    27c2:	50                   	push   %ax
    27c3:	e8 0e ec             	call   0x13d4
    27c6:	8d 36 ad 10          	lea    0x10ad,%si
    27ca:	b9 28 00             	mov    $0x28,%cx
    27cd:	fc                   	cld    
    27ce:	ac                   	lods   %ds:(%si),%al
    27cf:	56                   	push   %si
    27d0:	51                   	push   %cx
    27d1:	50                   	push   %ax
    27d2:	e8 ff eb             	call   0x13d4
    27d5:	59                   	pop    %cx
    27d6:	5e                   	pop    %si
    27d7:	e2 f4                	loop   0x27cd
    27d9:	c3                   	ret    
    27da:	b8 e3 00             	mov    $0xe3,%ax
    27dd:	50                   	push   %ax
    27de:	e8 f3 eb             	call   0x13d4
    27e1:	b8 f4 00             	mov    $0xf4,%ax
    27e4:	50                   	push   %ax
    27e5:	e8 ec eb             	call   0x13d4
    27e8:	c3                   	ret    
    27e9:	8a e0                	mov    %al,%ah
    27eb:	b0 53                	mov    $0x53,%al
    27ed:	80 fc 0d             	cmp    $0xd,%ah
    27f0:	74 2a                	je     0x281c
    27f2:	b0 52                	mov    $0x52,%al
    27f4:	80 fc 0e             	cmp    $0xe,%ah
    27f7:	74 23                	je     0x281c
    27f9:	b0 25                	mov    $0x25,%al
    27fb:	80 fc 1d             	cmp    $0x1d,%ah
    27fe:	74 1c                	je     0x281c
    2800:	b0 58                	mov    $0x58,%al
    2802:	80 fc 1e             	cmp    $0x1e,%ah
    2805:	74 15                	je     0x281c
    2807:	b0 f6                	mov    $0xf6,%al
    2809:	80 fc 1f             	cmp    $0x1f,%ah
    280c:	74 0e                	je     0x281c
    280e:	b0 2d                	mov    $0x2d,%al
    2810:	80 fc 20             	cmp    $0x20,%ah
    2813:	74 07                	je     0x281c
    2815:	b0 2b                	mov    $0x2b,%al
    2817:	80 fc 21             	cmp    $0x21,%ah
    281a:	75 01                	jne    0x281d
    281c:	c3                   	ret    
    281d:	b0 43                	mov    $0x43,%al
    281f:	80 fc 30             	cmp    $0x30,%ah
    2822:	74 f8                	je     0x281c
    2824:	b0 37                	mov    $0x37,%al
    2826:	80 fc 31             	cmp    $0x31,%ah
    2829:	74 f1                	je     0x281c
    282b:	b0 38                	mov    $0x38,%al
    282d:	80 fc 32             	cmp    $0x32,%ah
    2830:	74 ea                	je     0x281c
    2832:	b0 39                	mov    $0x39,%al
    2834:	80 fc 33             	cmp    $0x33,%ah
    2837:	74 e3                	je     0x281c
    2839:	b0 34                	mov    $0x34,%al
    283b:	80 fc 43             	cmp    $0x43,%ah
    283e:	74 dc                	je     0x281c
    2840:	b0 35                	mov    $0x35,%al
    2842:	80 fc 44             	cmp    $0x44,%ah
    2845:	74 1c                	je     0x2863
    2847:	b0 36                	mov    $0x36,%al
    2849:	80 fc 45             	cmp    $0x45,%ah
    284c:	74 15                	je     0x2863
    284e:	b0 31                	mov    $0x31,%al
    2850:	80 fc 54             	cmp    $0x54,%ah
    2853:	74 0e                	je     0x2863
    2855:	b0 32                	mov    $0x32,%al
    2857:	80 fc 55             	cmp    $0x55,%ah
    285a:	74 07                	je     0x2863
    285c:	b0 33                	mov    $0x33,%al
    285e:	80 fc 56             	cmp    $0x56,%ah
    2861:	75 01                	jne    0x2864
    2863:	c3                   	ret    
    2864:	b0 30                	mov    $0x30,%al
    2866:	80 fc 5e             	cmp    $0x5e,%ah
    2869:	74 f8                	je     0x2863
    286b:	b0 2e                	mov    $0x2e,%al
    286d:	80 fc 5f             	cmp    $0x5f,%ah
    2870:	74 f1                	je     0x2863
    2872:	b0 3d                	mov    $0x3d,%al
    2874:	80 fc 60             	cmp    $0x60,%ah
    2877:	74 ea                	je     0x2863
    2879:	b0 50                	mov    $0x50,%al
    287b:	80 fc 0b             	cmp    $0xb,%ah
    287e:	74 e3                	je     0x2863
    2880:	b0 4d                	mov    $0x4d,%al
    2882:	80 fc 0c             	cmp    $0xc,%ah
    2885:	74 dc                	je     0x2863
    2887:	b0 00                	mov    $0x0,%al
    2889:	c3                   	ret    
    288a:	8d 36 47 02          	lea    0x247,%si
    288e:	8d 3e 5b 02          	lea    0x25b,%di
    2892:	b9 09 00             	mov    $0x9,%cx
    2895:	fc                   	cld    
    2896:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2898:	c6 06 59 02 4d       	movb   $0x4d,0x259
    289d:	c6 06 5a 02 3d       	movb   $0x3d,0x25a
    28a2:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    28a7:	c3                   	ret    
    28a8:	8d 36 5b 02          	lea    0x25b,%si
    28ac:	8d 3e 47 02          	lea    0x247,%di
    28b0:	b9 09 00             	mov    $0x9,%cx
    28b3:	fc                   	cld    
    28b4:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    28b6:	a0 47 02             	mov    0x247,%al
    28b9:	3c 20                	cmp    $0x20,%al
    28bb:	75 03                	jne    0x28c0
    28bd:	e8 c4 fd             	call   0x2684
    28c0:	c6 06 c8 02 00       	movb   $0x0,0x2c8
    28c5:	c6 06 c9 02 00       	movb   $0x0,0x2c9
    28ca:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    28cf:	c6 06 cb 02 00       	movb   $0x0,0x2cb
    28d4:	c3                   	ret    
    28d5:	80 3e c8 02 00       	cmpb   $0x0,0x2c8
    28da:	74 07                	je     0x28e3
    28dc:	88 26 cc 02          	mov    %ah,0x2cc
    28e0:	e9 5b 00             	jmp    0x293e
    28e3:	88 26 cd 02          	mov    %ah,0x2cd
    28e7:	e8 5d fd             	call   0x2647
    28ea:	e8 e9 fa             	call   0x23d6
    28ed:	80 3e cc 02 00       	cmpb   $0x0,0x2cc
    28f2:	74 30                	je     0x2924
    28f4:	80 3e cc 02 01       	cmpb   $0x1,0x2cc
    28f9:	75 06                	jne    0x2901
    28fb:	e8 3b f8             	call   0x2139
    28fe:	e9 23 00             	jmp    0x2924
    2901:	80 3e cc 02 02       	cmpb   $0x2,0x2cc
    2906:	75 09                	jne    0x2911
    2908:	e8 a3 fa             	call   0x23ae
    290b:	e8 33 f8             	call   0x2141
    290e:	e9 13 00             	jmp    0x2924
    2911:	80 3e cc 02 03       	cmpb   $0x3,0x2cc
    2916:	75 06                	jne    0x291e
    2918:	e8 02 f9             	call   0x221d
    291b:	e9 06 00             	jmp    0x2924
    291e:	e8 8d fa             	call   0x23ae
    2921:	e8 66 f9             	call   0x228a
    2924:	8a 26 cd 02          	mov    0x2cd,%ah
    2928:	88 26 cc 02          	mov    %ah,0x2cc
    292c:	e8 0a fb             	call   0x2439
    292f:	8a 26 cf 02          	mov    0x2cf,%ah
    2933:	80 fc 00             	cmp    $0x0,%ah
    2936:	75 03                	jne    0x293b
    2938:	e8 5e fa             	call   0x2399
    293b:	e8 6b fd             	call   0x26a9
    293e:	c6 06 c8 02 01       	movb   $0x1,0x2c8
    2943:	c6 06 c9 02 00       	movb   $0x0,0x2c9
    2948:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    294d:	c6 06 cb 02 00       	movb   $0x0,0x2cb
    2952:	e9 9b 00             	jmp    0x29f0
    2955:	8b dc                	mov    %sp,%bx
    2957:	8b 47 02             	mov    0x2(%bx),%ax
    295a:	55                   	push   %bp
    295b:	3c 04                	cmp    $0x4,%al
    295d:	75 10                	jne    0x296f
    295f:	b8 00 00             	mov    $0x0,%ax
    2962:	50                   	push   %ax
    2963:	e8 6e ea             	call   0x13d4
    2966:	e8 56 fe             	call   0x27bf
    2969:	e8 6e fe             	call   0x27da
    296c:	e9 95 00             	jmp    0x2a04
    296f:	3c 09                	cmp    $0x9,%al
    2971:	75 0a                	jne    0x297d
    2973:	b8 ff ff             	mov    $0xffff,%ax
    2976:	50                   	push   %ax
    2977:	e8 5a ea             	call   0x13d4
    297a:	e9 76 00             	jmp    0x29f3
    297d:	e8 69 fe             	call   0x27e9
    2980:	3c 00                	cmp    $0x0,%al
    2982:	75 03                	jne    0x2987
    2984:	e9 6c 00             	jmp    0x29f3
    2987:	8a 26 cf 02          	mov    0x2cf,%ah
    298b:	80 fc 00             	cmp    $0x0,%ah
    298e:	74 07                	je     0x2997
    2990:	3c 43                	cmp    $0x43,%al
    2992:	75 5f                	jne    0x29f3
    2994:	e9 89 00             	jmp    0x2a20
    2997:	b4 00                	mov    $0x0,%ah
    2999:	3c 3d                	cmp    $0x3d,%al
    299b:	74 5a                	je     0x29f7
    299d:	fe c4                	inc    %ah
    299f:	3c 2b                	cmp    $0x2b,%al
    29a1:	74 54                	je     0x29f7
    29a3:	fe c4                	inc    %ah
    29a5:	3c 2d                	cmp    $0x2d,%al
    29a7:	74 4e                	je     0x29f7
    29a9:	fe c4                	inc    %ah
    29ab:	3c 58                	cmp    $0x58,%al
    29ad:	74 48                	je     0x29f7
    29af:	fe c4                	inc    %ah
    29b1:	3c f6                	cmp    $0xf6,%al
    29b3:	74 42                	je     0x29f7
    29b5:	fe c4                	inc    %ah
    29b7:	3c 25                	cmp    $0x25,%al
    29b9:	74 3f                	je     0x29fa
    29bb:	3c 43                	cmp    $0x43,%al
    29bd:	74 3e                	je     0x29fd
    29bf:	3c 2e                	cmp    $0x2e,%al
    29c1:	74 75                	je     0x2a38
    29c3:	3c 30                	cmp    $0x30,%al
    29c5:	72 2c                	jb     0x29f3
    29c7:	3c 39                	cmp    $0x39,%al
    29c9:	76 6d                	jbe    0x2a38
    29cb:	3c 53                	cmp    $0x53,%al
    29cd:	75 06                	jne    0x29d5
    29cf:	e8 b8 fe             	call   0x288a
    29d2:	e9 1b 00             	jmp    0x29f0
    29d5:	3c 52                	cmp    $0x52,%al
    29d7:	75 06                	jne    0x29df
    29d9:	e8 cc fe             	call   0x28a8
    29dc:	e9 11 00             	jmp    0x29f0
    29df:	3c 50                	cmp    $0x50,%al
    29e1:	75 06                	jne    0x29e9
    29e3:	e8 06 01             	call   0x2aec
    29e6:	e9 07 00             	jmp    0x29f0
    29e9:	3c 4d                	cmp    $0x4d,%al
    29eb:	75 03                	jne    0x29f0
    29ed:	e8 fc 00             	call   0x2aec
    29f0:	e8 69 fd             	call   0x275c
    29f3:	5d                   	pop    %bp
    29f4:	c2 02 00             	ret    $0x2
    29f7:	e9 db fe             	jmp    0x28d5
    29fa:	e9 a3 00             	jmp    0x2aa0
    29fd:	80 3e c9 02 00       	cmpb   $0x0,0x2c9
    2a02:	74 03                	je     0x2a07
    2a04:	e8 06 fd             	call   0x270d
    2a07:	e8 7a fc             	call   0x2684
    2a0a:	c6 06 c8 02 00       	movb   $0x0,0x2c8
    2a0f:	c6 06 c9 02 01       	movb   $0x1,0x2c9
    2a14:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    2a19:	c6 06 cb 02 00       	movb   $0x0,0x2cb
    2a1e:	eb d0                	jmp    0x29f0
    2a20:	c6 06 cf 02 00       	movb   $0x0,0x2cf
    2a25:	e8 61 f9             	call   0x2389
    2a28:	e8 8f fb             	call   0x25ba
    2a2b:	e8 0b fa             	call   0x2439
    2a2e:	e8 78 fc             	call   0x26a9
    2a31:	c6 06 cc 02 00       	movb   $0x0,0x2cc
    2a36:	eb b8                	jmp    0x29f0
    2a38:	50                   	push   %ax
    2a39:	80 3e ca 02 00       	cmpb   $0x0,0x2ca
    2a3e:	75 08                	jne    0x2a48
    2a40:	e8 41 fc             	call   0x2684
    2a43:	c6 06 ce 02 00       	movb   $0x0,0x2ce
    2a48:	8b 1e 7d 02          	mov    0x27d,%bx
    2a4c:	58                   	pop    %ax
    2a4d:	3c 2e                	cmp    $0x2e,%al
    2a4f:	75 16                	jne    0x2a67
    2a51:	80 3e ce 02 00       	cmpb   $0x0,0x2ce
    2a56:	75 9b                	jne    0x29f3
    2a58:	c6 06 ce 02 01       	movb   $0x1,0x2ce
    2a5d:	83 fb 00             	cmp    $0x0,%bx
    2a60:	75 0e                	jne    0x2a70
    2a62:	43                   	inc    %bx
    2a63:	fe 06 7d 02          	incb   0x27d
    2a67:	83 fb 00             	cmp    $0x0,%bx
    2a6a:	75 04                	jne    0x2a70
    2a6c:	3c 30                	cmp    $0x30,%al
    2a6e:	74 19                	je     0x2a89
    2a70:	83 fb 09             	cmp    $0x9,%bx
    2a73:	7f 28                	jg     0x2a9d
    2a75:	88 87 47 02          	mov    %al,0x247(%bx)
    2a79:	fe 06 7d 02          	incb   0x27d
    2a7d:	80 3e ce 02 00       	cmpb   $0x0,0x2ce
    2a82:	75 05                	jne    0x2a89
    2a84:	c6 87 48 02 2e       	movb   $0x2e,0x248(%bx)
    2a89:	c6 06 c8 02 00       	movb   $0x0,0x2c8
    2a8e:	c6 06 c9 02 00       	movb   $0x0,0x2c9
    2a93:	c6 06 ca 02 01       	movb   $0x1,0x2ca
    2a98:	c6 06 cb 02 00       	movb   $0x0,0x2cb
    2a9d:	e9 50 ff             	jmp    0x29f0
    2aa0:	80 3e cb 02 00       	cmpb   $0x0,0x2cb
    2aa5:	74 03                	je     0x2aaa
    2aa7:	e9 49 ff             	jmp    0x29f3
    2aaa:	80 3e cc 02 01       	cmpb   $0x1,0x2cc
    2aaf:	74 11                	je     0x2ac2
    2ab1:	80 3e cc 02 02       	cmpb   $0x2,0x2cc
    2ab6:	74 0a                	je     0x2ac2
    2ab8:	80 3e cc 02 00       	cmpb   $0x0,0x2cc
    2abd:	74 03                	je     0x2ac2
    2abf:	e9 31 ff             	jmp    0x29f3
    2ac2:	e8 82 fb             	call   0x2647
    2ac5:	e8 0e f9             	call   0x23d6
    2ac8:	fe 0e 80 02          	decb   0x280
    2acc:	e8 4e f7             	call   0x221d
    2acf:	e8 67 f9             	call   0x2439
    2ad2:	e8 d4 fb             	call   0x26a9
    2ad5:	c6 06 c8 02 00       	movb   $0x0,0x2c8
    2ada:	c6 06 c9 02 00       	movb   $0x0,0x2c9
    2adf:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    2ae4:	c6 06 cb 02 01       	movb   $0x1,0x2cb
    2ae9:	e9 04 ff             	jmp    0x29f0
    2aec:	50                   	push   %ax
    2aed:	8d 36 5b 02          	lea    0x25b,%si
    2af1:	8d 3e 6f 02          	lea    0x26f,%di
    2af5:	b9 06 00             	mov    $0x6,%cx
    2af8:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2afa:	e8 61 00             	call   0x2b5e
    2afd:	e8 47 fb             	call   0x2647
    2b00:	e8 d3 f8             	call   0x23d6
    2b03:	e8 93 f8             	call   0x2399
    2b06:	e8 73 00             	call   0x2b7c
    2b09:	80 3e 47 02 20       	cmpb   $0x20,0x247
    2b0e:	75 06                	jne    0x2b16
    2b10:	c7 06 47 02 30 2e    	movw   $0x2e30,0x247
    2b16:	e8 2e fb             	call   0x2647
    2b19:	e8 ba f8             	call   0x23d6
    2b1c:	58                   	pop    %ax
    2b1d:	3c 50                	cmp    $0x50,%al
    2b1f:	75 06                	jne    0x2b27
    2b21:	e8 15 f6             	call   0x2139
    2b24:	e9 03 00             	jmp    0x2b2a
    2b27:	e8 17 f6             	call   0x2141
    2b2a:	e8 0c f9             	call   0x2439
    2b2d:	e8 79 fb             	call   0x26a9
    2b30:	80 3e 47 02 45       	cmpb   $0x45,0x247
    2b35:	74 13                	je     0x2b4a
    2b37:	e8 42 00             	call   0x2b7c
    2b3a:	e8 30 00             	call   0x2b6d
    2b3d:	c6 06 59 02 4d       	movb   $0x4d,0x259
    2b42:	c6 06 5a 02 3d       	movb   $0x3d,0x25a
    2b47:	e9 0e 00             	jmp    0x2b58
    2b4a:	8d 36 6f 02          	lea    0x26f,%si
    2b4e:	8d 3e 5b 02          	lea    0x25b,%di
    2b52:	b9 06 00             	mov    $0x6,%cx
    2b55:	fc                   	cld    
    2b56:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2b58:	c6 06 ca 02 00       	movb   $0x0,0x2ca
    2b5d:	c3                   	ret    
    2b5e:	8d 36 7f 02          	lea    0x27f,%si
    2b62:	8d 3e 91 02          	lea    0x291,%di
    2b66:	b9 09 00             	mov    $0x9,%cx
    2b69:	fc                   	cld    
    2b6a:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2b6c:	c3                   	ret    
    2b6d:	8d 36 91 02          	lea    0x291,%si
    2b71:	8d 3e 7f 02          	lea    0x27f,%di
    2b75:	b9 09 00             	mov    $0x9,%cx
    2b78:	fc                   	cld    
    2b79:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2b7b:	c3                   	ret    
    2b7c:	fc                   	cld    
    2b7d:	8d 36 47 02          	lea    0x247,%si
    2b81:	8d 3e 47 02          	lea    0x247,%di
    2b85:	ad                   	lods   %ds:(%si),%ax
    2b86:	87 06 5b 02          	xchg   %ax,0x25b
    2b8a:	ab                   	stos   %ax,%es:(%di)
    2b8b:	ad                   	lods   %ds:(%si),%ax
    2b8c:	87 06 5d 02          	xchg   %ax,0x25d
    2b90:	ab                   	stos   %ax,%es:(%di)
    2b91:	ad                   	lods   %ds:(%si),%ax
    2b92:	87 06 5f 02          	xchg   %ax,0x25f
    2b96:	ab                   	stos   %ax,%es:(%di)
    2b97:	ad                   	lods   %ds:(%si),%ax
    2b98:	87 06 61 02          	xchg   %ax,0x261
    2b9c:	ab                   	stos   %ax,%es:(%di)
    2b9d:	ad                   	lods   %ds:(%si),%ax
    2b9e:	87 06 63 02          	xchg   %ax,0x263
    2ba2:	ab                   	stos   %ax,%es:(%di)
    2ba3:	ad                   	lods   %ds:(%si),%ax
    2ba4:	87 06 65 02          	xchg   %ax,0x265
    2ba8:	ab                   	stos   %ax,%es:(%di)
    2ba9:	c3                   	ret    
    2baa:	b9 ff ff             	mov    $0xffff,%cx
    2bad:	fa                   	cli    
    2bae:	33 c0                	xor    %ax,%ax
    2bb0:	e6 82                	out    %al,$0x82
    2bb2:	b0 81                	mov    $0x81,%al
    2bb4:	e6 4e                	out    %al,$0x4e
    2bb6:	b0 1b                	mov    $0x1b,%al
    2bb8:	e6 4a                	out    %al,$0x4a
    2bba:	b0 1a                	mov    $0x1a,%al
    2bbc:	e6 4a                	out    %al,$0x4a
    2bbe:	b0 7f                	mov    $0x7f,%al
    2bc0:	e6 4c                	out    %al,$0x4c
    2bc2:	b0 1b                	mov    $0x1b,%al
    2bc4:	e6 4a                	out    %al,$0x4a
    2bc6:	fc                   	cld    
    2bc7:	33 db                	xor    %bx,%bx
    2bc9:	be f3 1a             	mov    $0x1af3,%si
    2bcc:	8a c3                	mov    %bl,%al
    2bce:	e6 68                	out    %al,$0x68
    2bd0:	2e 8a 00             	mov    %cs:(%bx,%si),%al
    2bd3:	e6 6a                	out    %al,$0x6a
    2bd5:	43                   	inc    %bx
    2bd6:	80 fb 10             	cmp    $0x10,%bl
    2bd9:	75 f1                	jne    0x2bcc
    2bdb:	b8 00 40             	mov    $0x4000,%ax
    2bde:	8e d8                	mov    %ax,%ds
    2be0:	b8 41 53             	mov    $0x5341,%ax
    2be3:	bb 02 00             	mov    $0x2,%bx
    2be6:	c7 07 00 00          	movw   $0x0,(%bx)
    2bea:	3b 07                	cmp    (%bx),%ax
    2bec:	75 16                	jne    0x2c04
    2bee:	ea 00 00 01 40       	ljmp   $0x4001,$0x0
    2bf3:	5e                   	pop    %si
    2bf4:	50                   	push   %ax
    2bf5:	4f                   	dec    %di
    2bf6:	0c 19                	or     $0x19,%al
    2bf8:	0a 19                	or     (%bx,%di),%bl
    2bfa:	19 03                	sbb    %ax,(%bp,%di)
    2bfc:	0e                   	push   %cs
    2bfd:	0f 00 00             	sldt   (%bx,%si)
    2c00:	00 3a                	add    %bh,(%bp,%si)
    2c02:	c3                   	ret    
    2c03:	ff                   	(bad)  
    2c04:	b8 40 00             	mov    $0x40,%ax
    2c07:	8e d8                	mov    %ax,%ds
    2c09:	bd ff ff             	mov    $0xffff,%bp
    2c0c:	a1 04 00             	mov    0x4,%ax
    2c0f:	3d 34 12             	cmp    $0x1234,%ax
    2c12:	75 0c                	jne    0x2c20
    2c14:	a1 06 00             	mov    0x6,%ax
    2c17:	3d 78 56             	cmp    $0x5678,%ax
    2c1a:	75 04                	jne    0x2c20
    2c1c:	33 ed                	xor    %bp,%bp
    2c1e:	eb 1c                	jmp    0x2c3c
    2c20:	b8 00 fc             	mov    $0xfc00,%ax
    2c23:	8e d8                	mov    %ax,%ds
    2c25:	33 c0                	xor    %ax,%ax
    2c27:	bb fe 1f             	mov    $0x1ffe,%bx
    2c2a:	03 07                	add    (%bx),%ax
    2c2c:	4b                   	dec    %bx
    2c2d:	4b                   	dec    %bx
    2c2e:	83 fb 00             	cmp    $0x0,%bx
    2c31:	75 f7                	jne    0x2c2a
    2c33:	8b 17                	mov    (%bx),%dx
    2c35:	3b c2                	cmp    %dx,%ax
    2c37:	74 03                	je     0x2c3c
    2c39:	80 e1 fe             	and    $0xfe,%cl
    2c3c:	8b d9                	mov    %cx,%bx
    2c3e:	b1 1d                	mov    $0x1d,%cl
    2c40:	b0 9f                	mov    $0x9f,%al
    2c42:	e6 50                	out    %al,$0x50
    2c44:	d2 e5                	shl    %cl,%ch
    2c46:	b0 bf                	mov    $0xbf,%al
    2c48:	e6 50                	out    %al,$0x50
    2c4a:	d2 e5                	shl    %cl,%ch
    2c4c:	b0 df                	mov    $0xdf,%al
    2c4e:	e6 50                	out    %al,$0x50
    2c50:	d2 e5                	shl    %cl,%ch
    2c52:	b0 ff                	mov    $0xff,%al
    2c54:	e6 50                	out    %al,$0x50
    2c56:	d2 e5                	shl    %cl,%ch
    2c58:	8b cb                	mov    %bx,%cx
    2c5a:	b0 18                	mov    $0x18,%al
    2c5c:	e6 62                	out    %al,$0x62
    2c5e:	e6 66                	out    %al,$0x66
    2c60:	b0 02                	mov    $0x2,%al
    2c62:	e6 62                	out    %al,$0x62
    2c64:	e6 66                	out    %al,$0x66
    2c66:	b0 00                	mov    $0x0,%al
    2c68:	e6 62                	out    %al,$0x62
    2c6a:	e6 66                	out    %al,$0x66
    2c6c:	b0 04                	mov    $0x4,%al
    2c6e:	e6 62                	out    %al,$0x62
    2c70:	b0 48                	mov    $0x48,%al
    2c72:	e6 62                	out    %al,$0x62
    2c74:	b0 04                	mov    $0x4,%al
    2c76:	e6 66                	out    %al,$0x66
    2c78:	b0 88                	mov    $0x88,%al
    2c7a:	e6 66                	out    %al,$0x66
    2c7c:	b0 05                	mov    $0x5,%al
    2c7e:	e6 62                	out    %al,$0x62
    2c80:	e6 66                	out    %al,$0x66
    2c82:	b0 ea                	mov    $0xea,%al
    2c84:	e6 62                	out    %al,$0x62
    2c86:	e6 66                	out    %al,$0x66
    2c88:	b0 03                	mov    $0x3,%al
    2c8a:	e6 62                	out    %al,$0x62
    2c8c:	e6 66                	out    %al,$0x66
    2c8e:	b0 c1                	mov    $0xc1,%al
    2c90:	e6 62                	out    %al,$0x62
    2c92:	e6 66                	out    %al,$0x66
    2c94:	b0 01                	mov    $0x1,%al
    2c96:	e6 62                	out    %al,$0x62
    2c98:	e6 66                	out    %al,$0x66
    2c9a:	b0 00                	mov    $0x0,%al
    2c9c:	e6 62                	out    %al,$0x62
    2c9e:	e6 66                	out    %al,$0x66
    2ca0:	b0 00                	mov    $0x0,%al
    2ca2:	e6 66                	out    %al,$0x66
    2ca4:	e4 66                	in     $0x66,%al
    2ca6:	24 08                	and    $0x8,%al
    2ca8:	74 21                	je     0x2ccb
    2caa:	b0 0d                	mov    $0xd,%al
    2cac:	e6 48                	out    %al,$0x48
    2cae:	b0 0f                	mov    $0xf,%al
    2cb0:	e6 4c                	out    %al,$0x4c
    2cb2:	bb 54 76             	mov    $0x7654,%bx
    2cb5:	b0 7f                	mov    $0x7f,%al
    2cb7:	e6 4c                	out    %al,$0x4c
    2cb9:	b0 00                	mov    $0x0,%al
    2cbb:	e6 66                	out    %al,$0x66
    2cbd:	e4 66                	in     $0x66,%al
    2cbf:	24 08                	and    $0x8,%al
    2cc1:	75 05                	jne    0x2cc8
    2cc3:	4b                   	dec    %bx
    2cc4:	75 f3                	jne    0x2cb9
    2cc6:	eb 03                	jmp    0x2ccb
    2cc8:	80 e5 7f             	and    $0x7f,%ch
    2ccb:	83 fd 00             	cmp    $0x0,%bp
    2cce:	74 48                	je     0x2d18
    2cd0:	b0 0e                	mov    $0xe,%al
    2cd2:	e6 68                	out    %al,$0x68
    2cd4:	e4 6a                	in     $0x6a,%al
    2cd6:	24 3f                	and    $0x3f,%al
    2cd8:	3c 3a                	cmp    $0x3a,%al
    2cda:	74 03                	je     0x2cdf
    2cdc:	80 e1 f7             	and    $0xf7,%cl
    2cdf:	b0 0f                	mov    $0xf,%al
    2ce1:	e6 68                	out    %al,$0x68
    2ce3:	e4 6a                	in     $0x6a,%al
    2ce5:	3c c3                	cmp    $0xc3,%al
    2ce7:	74 03                	je     0x2cec
    2ce9:	80 e1 f7             	and    $0xf7,%cl
    2cec:	b0 0e                	mov    $0xe,%al
    2cee:	e6 68                	out    %al,$0x68
    2cf0:	b0 00                	mov    $0x0,%al
    2cf2:	e6 6a                	out    %al,$0x6a
    2cf4:	b0 0f                	mov    $0xf,%al
    2cf6:	e6 68                	out    %al,$0x68
    2cf8:	b0 00                	mov    $0x0,%al
    2cfa:	e6 6a                	out    %al,$0x6a
    2cfc:	b0 0e                	mov    $0xe,%al
    2cfe:	e6 68                	out    %al,$0x68
    2d00:	e4 6a                	in     $0x6a,%al
    2d02:	24 3f                	and    $0x3f,%al
    2d04:	3c 00                	cmp    $0x0,%al
    2d06:	74 03                	je     0x2d0b
    2d08:	80 e1 f7             	and    $0xf7,%cl
    2d0b:	b0 0f                	mov    $0xf,%al
    2d0d:	e6 68                	out    %al,$0x68
    2d0f:	e4 6a                	in     $0x6a,%al
    2d11:	3c 00                	cmp    $0x0,%al
    2d13:	74 03                	je     0x2d18
    2d15:	80 e1 f7             	and    $0xf7,%cl
    2d18:	b8 00 f0             	mov    $0xf000,%ax
    2d1b:	8e d8                	mov    %ax,%ds
    2d1d:	bb 00 10             	mov    $0x1000,%bx
    2d20:	33 d2                	xor    %dx,%dx
    2d22:	4b                   	dec    %bx
    2d23:	4b                   	dec    %bx
    2d24:	89 1f                	mov    %bx,(%bx)
    2d26:	3b da                	cmp    %dx,%bx
    2d28:	75 f8                	jne    0x2d22
    2d2a:	bb fe 0f             	mov    $0xffe,%bx
    2d2d:	8b 07                	mov    (%bx),%ax
    2d2f:	3b c3                	cmp    %bx,%ax
    2d31:	74 03                	je     0x2d36
    2d33:	80 e1 ef             	and    $0xef,%cl
    2d36:	b8 40 03             	mov    $0x340,%ax
    2d39:	89 07                	mov    %ax,(%bx)
    2d3b:	4b                   	dec    %bx
    2d3c:	4b                   	dec    %bx
    2d3d:	89 07                	mov    %ax,(%bx)
    2d3f:	4b                   	dec    %bx
    2d40:	4b                   	dec    %bx
    2d41:	3b da                	cmp    %dx,%bx
    2d43:	7f e8                	jg     0x2d2d
    2d45:	b8 08 f0             	mov    $0xf008,%ax
    2d48:	8e d8                	mov    %ax,%ds
    2d4a:	33 db                	xor    %bx,%bx
    2d4c:	c7 07 40 03          	movw   $0x340,(%bx)
    2d50:	43                   	inc    %bx
    2d51:	43                   	inc    %bx
    2d52:	80 fb 20             	cmp    $0x20,%bl
    2d55:	75 f5                	jne    0x2d4c
    2d57:	bb a0 00             	mov    $0xa0,%bx
    2d5a:	8b c3                	mov    %bx,%ax
    2d5c:	d1 e8                	shr    %ax
    2d5e:	2d 31 00             	sub    $0x31,%ax
    2d61:	05 40 03             	add    $0x340,%ax
    2d64:	89 07                	mov    %ax,(%bx)
    2d66:	43                   	inc    %bx
    2d67:	43                   	inc    %bx
    2d68:	81 fb c0 00          	cmp    $0xc0,%bx
    2d6c:	75 ec                	jne    0x2d5a
    2d6e:	bb 40 01             	mov    $0x140,%bx
    2d71:	8b c3                	mov    %bx,%ax
    2d73:	d1 e8                	shr    %ax
    2d75:	2d 71 00             	sub    $0x71,%ax
    2d78:	05 40 03             	add    $0x340,%ax
    2d7b:	89 07                	mov    %ax,(%bx)
    2d7d:	43                   	inc    %bx
    2d7e:	43                   	inc    %bx
    2d7f:	81 fb 60 01          	cmp    $0x160,%bx
    2d83:	75 ec                	jne    0x2d71
    2d85:	bb 10 00             	mov    $0x10,%bx
    2d88:	b8 2e 00             	mov    $0x2e,%ax
    2d8b:	05 40 03             	add    $0x340,%ax
    2d8e:	89 07                	mov    %ax,(%bx)
    2d90:	83 c3 0a             	add    $0xa,%bx
    2d93:	b8 2f 00             	mov    $0x2f,%ax
    2d96:	05 40 03             	add    $0x340,%ax
    2d99:	89 07                	mov    %ax,(%bx)
    2d9b:	b8 40 03             	mov    $0x340,%ax
    2d9e:	bb a0 00             	mov    $0xa0,%bx
    2da1:	89 07                	mov    %ax,(%bx)
    2da3:	43                   	inc    %bx
    2da4:	43                   	inc    %bx
    2da5:	89 07                	mov    %ax,(%bx)
    2da7:	83 c3 1c             	add    $0x1c,%bx
    2daa:	89 07                	mov    %ax,(%bx)
    2dac:	bb 40 01             	mov    $0x140,%bx
    2daf:	89 07                	mov    %ax,(%bx)
    2db1:	43                   	inc    %bx
    2db2:	43                   	inc    %bx
    2db3:	89 07                	mov    %ax,(%bx)
    2db5:	83 c3 1c             	add    $0x1c,%bx
    2db8:	89 07                	mov    %ax,(%bx)
    2dba:	83 fd 00             	cmp    $0x0,%bp
    2dbd:	75 03                	jne    0x2dc2
    2dbf:	e9 93 00             	jmp    0x2e55
    2dc2:	8b d1                	mov    %cx,%dx
    2dc4:	b8 b4 f0             	mov    $0xf0b4,%ax
    2dc7:	8e d8                	mov    %ax,%ds
    2dc9:	bb 14 00             	mov    $0x14,%bx
    2dcc:	b8 4b 03             	mov    $0x34b,%ax
    2dcf:	b9 07 00             	mov    $0x7,%cx
    2dd2:	89 07                	mov    %ax,(%bx)
    2dd4:	43                   	inc    %bx
    2dd5:	43                   	inc    %bx
    2dd6:	40                   	inc    %ax
    2dd7:	e2 f9                	loop   0x2dd2
    2dd9:	8b ca                	mov    %dx,%cx
    2ddb:	b8 00 30             	mov    $0x3000,%ax
    2dde:	8e d8                	mov    %ax,%ds
    2de0:	ba fe ff             	mov    $0xfffe,%dx
    2de3:	bb fe ff             	mov    $0xfffe,%bx
    2de6:	89 1f                	mov    %bx,(%bx)
    2de8:	4b                   	dec    %bx
    2de9:	4b                   	dec    %bx
    2dea:	3b da                	cmp    %dx,%bx
    2dec:	75 f8                	jne    0x2de6
    2dee:	8c d8                	mov    %ds,%ax
    2df0:	2d 00 10             	sub    $0x1000,%ax
    2df3:	8e d8                	mov    %ax,%ds
    2df5:	73 ef                	jae    0x2de6
    2df7:	b8 00 30             	mov    $0x3000,%ax
    2dfa:	8e d8                	mov    %ax,%ds
    2dfc:	8b 07                	mov    (%bx),%ax
    2dfe:	3b c3                	cmp    %bx,%ax
    2e00:	74 03                	je     0x2e05
    2e02:	80 e1 df             	and    $0xdf,%cl
    2e05:	4b                   	dec    %bx
    2e06:	4b                   	dec    %bx
    2e07:	3b da                	cmp    %dx,%bx
    2e09:	75 f1                	jne    0x2dfc
    2e0b:	8c d8                	mov    %ds,%ax
    2e0d:	2d 00 10             	sub    $0x1000,%ax
    2e10:	8e d8                	mov    %ax,%ds
    2e12:	73 e8                	jae    0x2dfc
    2e14:	b8 ff 3f             	mov    $0x3fff,%ax
    2e17:	8e d8                	mov    %ax,%ds
    2e19:	bb 0e 00             	mov    $0xe,%bx
    2e1c:	8c 1f                	mov    %ds,(%bx)
    2e1e:	4b                   	dec    %bx
    2e1f:	4b                   	dec    %bx
    2e20:	3b da                	cmp    %dx,%bx
    2e22:	75 f8                	jne    0x2e1c
    2e24:	8c d8                	mov    %ds,%ax
    2e26:	2d 01 00             	sub    $0x1,%ax
    2e29:	8e d8                	mov    %ax,%ds
    2e2b:	73 ec                	jae    0x2e19
    2e2d:	b8 ff 3f             	mov    $0x3fff,%ax
    2e30:	8e d8                	mov    %ax,%ds
    2e32:	bb 0e 00             	mov    $0xe,%bx
    2e35:	8b 07                	mov    (%bx),%ax
    2e37:	c7 07 00 00          	movw   $0x0,(%bx)
    2e3b:	8c da                	mov    %ds,%dx
    2e3d:	3b c2                	cmp    %dx,%ax
    2e3f:	74 03                	je     0x2e44
    2e41:	80 e1 df             	and    $0xdf,%cl
    2e44:	4b                   	dec    %bx
    2e45:	4b                   	dec    %bx
    2e46:	81 fb fe ff          	cmp    $0xfffe,%bx
    2e4a:	75 e9                	jne    0x2e35
    2e4c:	8c d8                	mov    %ds,%ax
    2e4e:	2d 01 00             	sub    $0x1,%ax
    2e51:	8e d8                	mov    %ax,%ds
    2e53:	73 dd                	jae    0x2e32
    2e55:	b8 00 30             	mov    $0x3000,%ax
    2e58:	8e d0                	mov    %ax,%ss
    2e5a:	bc fe ff             	mov    $0xfffe,%sp
    2e5d:	83 fd 00             	cmp    $0x0,%bp
    2e60:	74 46                	je     0x2ea8
    2e62:	f6 c5 80             	test   $0x80,%ch
    2e65:	75 11                	jne    0x2e78
    2e67:	b3 00                	mov    $0x0,%bl
    2e69:	8a c3                	mov    %bl,%al
    2e6b:	e8 38 00             	call   0x2ea6
    2e6e:	fe c3                	inc    %bl
    2e70:	80 fb ff             	cmp    $0xff,%bl
    2e73:	75 f4                	jne    0x2e69
    2e75:	e9 13 00             	jmp    0x2e8b
    2e78:	be 91 1d             	mov    $0x1d91,%si
    2e7b:	33 db                	xor    %bx,%bx
    2e7d:	2e 8a 00             	mov    %cs:(%bx,%si),%al
    2e80:	e8 23 00             	call   0x2ea6
    2e83:	e8 21 00             	call   0x2ea7
    2e86:	43                   	inc    %bx
    2e87:	3c ff                	cmp    $0xff,%al
    2e89:	75 f2                	jne    0x2e7d
    2e8b:	80 c9 40             	or     $0x40,%cl
    2e8e:	e9 17 00             	jmp    0x2ea8
    2e91:	41                   	inc    %cx
    2e92:	70 72                	jo     0x2f06
    2e94:	69 63 6f 74 20       	imul   $0x2074,0x6f(%bp,%di),%sp
    2e99:	53                   	push   %bx
    2e9a:	65 6c                	gs insb (%dx),%es:(%di)
    2e9c:	66 20 54 65          	data32 and %dl,0x65(%si)
    2ea0:	73 74                	jae    0x2f16
    2ea2:	73 0d                	jae    0x2eb1
    2ea4:	0a ff                	or     %bh,%bh
    2ea6:	c3                   	ret    
    2ea7:	c3                   	ret    
    2ea8:	b0 1b                	mov    $0x1b,%al
    2eaa:	e6 00                	out    %al,$0x0
    2eac:	b0 50                	mov    $0x50,%al
    2eae:	e6 02                	out    %al,$0x2
    2eb0:	b0 01                	mov    $0x1,%al
    2eb2:	e6 02                	out    %al,$0x2
    2eb4:	b0 4b                	mov    $0x4b,%al
    2eb6:	e6 02                	out    %al,$0x2
    2eb8:	e4 02                	in     $0x2,%al
    2eba:	3c 4b                	cmp    $0x4b,%al
    2ebc:	74 03                	je     0x2ec1
    2ebe:	80 e1 7f             	and    $0x7f,%cl
    2ec1:	b0 ff                	mov    $0xff,%al
    2ec3:	e6 02                	out    %al,$0x2
    2ec5:	e4 02                	in     $0x2,%al
    2ec7:	3c ff                	cmp    $0xff,%al
    2ec9:	74 03                	je     0x2ece
    2ecb:	80 e1 7f             	and    $0x7f,%cl
    2ece:	b0 13                	mov    $0x13,%al
    2ed0:	e6 4a                	out    %al,$0x4a
    2ed2:	8b d9                	mov    %cx,%bx
    2ed4:	b8 80 fc             	mov    $0xfc80,%ax
    2ed7:	8e d8                	mov    %ax,%ds
    2ed9:	b8 80 06             	mov    $0x680,%ax
    2edc:	8e c0                	mov    %ax,%es
    2ede:	33 f6                	xor    %si,%si
    2ee0:	8b fe                	mov    %si,%di
    2ee2:	b9 80 04             	mov    $0x480,%cx
    2ee5:	fc                   	cld    
    2ee6:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    2ee8:	8b cb                	mov    %bx,%cx
    2eea:	83 fd 00             	cmp    $0x0,%bp
    2eed:	74 4c                	je     0x2f3b
    2eef:	b0 13                	mov    $0x13,%al
    2ef1:	e6 4a                	out    %al,$0x4a
    2ef3:	b0 03                	mov    $0x3,%al
    2ef5:	e6 40                	out    %al,$0x40
    2ef7:	b8 b0 13             	mov    $0x13b0,%ax
    2efa:	e8 45 00             	call   0x2f42
    2efd:	b0 23                	mov    $0x23,%al
    2eff:	e6 46                	out    %al,$0x46
    2f01:	b0 13                	mov    $0x13,%al
    2f03:	e6 40                	out    %al,$0x40
    2f05:	b8 b0 13             	mov    $0x13b0,%ax
    2f08:	e8 37 00             	call   0x2f42
    2f0b:	b0 03                	mov    $0x3,%al
    2f0d:	e6 40                	out    %al,$0x40
    2f0f:	b8 b0 13             	mov    $0x13b0,%ax
    2f12:	e8 2d 00             	call   0x2f42
    2f15:	b0 1e                	mov    $0x1e,%al
    2f17:	e6 44                	out    %al,$0x44
    2f19:	b8 01 00             	mov    $0x1,%ax
    2f1c:	e8 23 00             	call   0x2f42
    2f1f:	e4 44                	in     $0x44,%al
    2f21:	3c 1e                	cmp    $0x1e,%al
    2f23:	74 03                	je     0x2f28
    2f25:	80 e5 fe             	and    $0xfe,%ch
    2f28:	b0 01                	mov    $0x1,%al
    2f2a:	e6 44                	out    %al,$0x44
    2f2c:	b8 01 00             	mov    $0x1,%ax
    2f2f:	e8 10 00             	call   0x2f42
    2f32:	e4 44                	in     $0x44,%al
    2f34:	3c 01                	cmp    $0x1,%al
    2f36:	74 03                	je     0x2f3b
    2f38:	80 e5 fe             	and    $0xfe,%ch
    2f3b:	b0 d0                	mov    $0xd0,%al
    2f3d:	e6 40                	out    %al,$0x40
    2f3f:	e9 0c 00             	jmp    0x2f4e
    2f42:	8b d9                	mov    %cx,%bx
    2f44:	b1 ff                	mov    $0xff,%cl
    2f46:	d2 e5                	shl    %cl,%ch
    2f48:	48                   	dec    %ax
    2f49:	75 fb                	jne    0x2f46
    2f4b:	8b cb                	mov    %bx,%cx
    2f4d:	c3                   	ret    
    2f4e:	b0 b0                	mov    $0xb0,%al
    2f50:	e6 5e                	out    %al,$0x5e
    2f52:	b0 47                	mov    $0x47,%al
    2f54:	e6 5c                	out    %al,$0x5c
    2f56:	e4 5c                	in     $0x5c,%al
    2f58:	34 ff                	xor    $0xff,%al
    2f5a:	3c 47                	cmp    $0x47,%al
    2f5c:	e6 5c                	out    %al,$0x5c
    2f5e:	74 03                	je     0x2f63
    2f60:	80 e5 fd             	and    $0xfd,%ch
    2f63:	b0 b6                	mov    $0xb6,%al
    2f65:	e6 5e                	out    %al,$0x5e
    2f67:	b0 10                	mov    $0x10,%al
    2f69:	e6 5c                	out    %al,$0x5c
    2f6b:	b0 00                	mov    $0x0,%al
    2f6d:	e6 5c                	out    %al,$0x5c
    2f6f:	b0 76                	mov    $0x76,%al
    2f71:	e6 5e                	out    %al,$0x5e
    2f73:	b0 10                	mov    $0x10,%al
    2f75:	e6 5a                	out    %al,$0x5a
    2f77:	b0 00                	mov    $0x0,%al
    2f79:	e6 5a                	out    %al,$0x5a
    2f7b:	80 e5 f7             	and    $0xf7,%ch
    2f7e:	b0 e8                	mov    $0xe8,%al
    2f80:	e6 64                	out    %al,$0x64
    2f82:	b8 ff 00             	mov    $0xff,%ax
    2f85:	e8 ba ff             	call   0x2f42
    2f88:	e4 60                	in     $0x60,%al
    2f8a:	e4 64                	in     $0x64,%al
    2f8c:	b0 41                	mov    $0x41,%al
    2f8e:	e6 60                	out    %al,$0x60
    2f90:	e8 6e 00             	call   0x3001
    2f93:	73 56                	jae    0x2feb
    2f95:	3c 41                	cmp    $0x41,%al
    2f97:	75 52                	jne    0x2feb
    2f99:	b0 42                	mov    $0x42,%al
    2f9b:	e6 64                	out    %al,$0x64
    2f9d:	e8 7e 00             	call   0x301e
    2fa0:	73 46                	jae    0x2fe8
    2fa2:	3c 42                	cmp    $0x42,%al
    2fa4:	75 42                	jne    0x2fe8
    2fa6:	80 cd 08             	or     $0x8,%ch
    2fa9:	b0 05                	mov    $0x5,%al
    2fab:	e6 62                	out    %al,$0x62
    2fad:	b0 68                	mov    $0x68,%al
    2faf:	e8 44 00             	call   0x2ff6
    2fb2:	24 28                	and    $0x28,%al
    2fb4:	3c 00                	cmp    $0x0,%al
    2fb6:	75 30                	jne    0x2fe8
    2fb8:	b0 05                	mov    $0x5,%al
    2fba:	e6 62                	out    %al,$0x62
    2fbc:	b0 e8                	mov    $0xe8,%al
    2fbe:	e8 35 00             	call   0x2ff6
    2fc1:	24 28                	and    $0x28,%al
    2fc3:	3c 08                	cmp    $0x8,%al
    2fc5:	75 21                	jne    0x2fe8
    2fc7:	b0 05                	mov    $0x5,%al
    2fc9:	e6 62                	out    %al,$0x62
    2fcb:	b0 6a                	mov    $0x6a,%al
    2fcd:	e8 26 00             	call   0x2ff6
    2fd0:	24 28                	and    $0x28,%al
    2fd2:	3c 20                	cmp    $0x20,%al
    2fd4:	75 12                	jne    0x2fe8
    2fd6:	b0 05                	mov    $0x5,%al
    2fd8:	e6 62                	out    %al,$0x62
    2fda:	b0 ea                	mov    $0xea,%al
    2fdc:	e8 17 00             	call   0x2ff6
    2fdf:	24 28                	and    $0x28,%al
    2fe1:	3c 28                	cmp    $0x28,%al
    2fe3:	75 56                	jne    0x303b
    2fe5:	80 cd 04             	or     $0x4,%ch
    2fe8:	e9 50 00             	jmp    0x303b
    2feb:	e8 30 00             	call   0x301e
    2fee:	73 4b                	jae    0x303b
    2ff0:	3c 41                	cmp    $0x41,%al
    2ff2:	75 47                	jne    0x303b
    2ff4:	eb b3                	jmp    0x2fa9
    2ff6:	e6 62                	out    %al,$0x62
    2ff8:	b0 00                	mov    $0x0,%al
    2ffa:	0c 10                	or     $0x10,%al
    2ffc:	e6 62                	out    %al,$0x62
    2ffe:	e4 62                	in     $0x62,%al
    3000:	c3                   	ret    
    3001:	8b d1                	mov    %cx,%dx
    3003:	b1 ff                	mov    $0xff,%cl
    3005:	bb 15 00             	mov    $0x15,%bx
    3008:	d2 e5                	shl    %cl,%ch
    300a:	f8                   	clc    
    300b:	4b                   	dec    %bx
    300c:	74 0d                	je     0x301b
    300e:	b0 00                	mov    $0x0,%al
    3010:	e6 66                	out    %al,$0x66
    3012:	e4 66                	in     $0x66,%al
    3014:	a8 01                	test   $0x1,%al
    3016:	74 f0                	je     0x3008
    3018:	e4 64                	in     $0x64,%al
    301a:	f9                   	stc    
    301b:	8b ca                	mov    %dx,%cx
    301d:	c3                   	ret    
    301e:	8b d1                	mov    %cx,%dx
    3020:	b1 ff                	mov    $0xff,%cl
    3022:	bb 15 00             	mov    $0x15,%bx
    3025:	d2 e5                	shl    %cl,%ch
    3027:	f8                   	clc    
    3028:	4b                   	dec    %bx
    3029:	74 0d                	je     0x3038
    302b:	b0 00                	mov    $0x0,%al
    302d:	e6 62                	out    %al,$0x62
    302f:	e4 62                	in     $0x62,%al
    3031:	a8 01                	test   $0x1,%al
    3033:	74 f0                	je     0x3025
    3035:	e4 60                	in     $0x60,%al
    3037:	f9                   	stc    
    3038:	8b ca                	mov    %dx,%cx
    303a:	c3                   	ret    
    303b:	e4 64                	in     $0x64,%al
    303d:	b0 e8                	mov    $0xe8,%al
    303f:	e6 64                	out    %al,$0x64
    3041:	b8 ff 00             	mov    $0xff,%ax
    3044:	e8 fb fe             	call   0x2f42
    3047:	e8 b7 ff             	call   0x3001
    304a:	73 04                	jae    0x3050
    304c:	3c fb                	cmp    $0xfb,%al
    304e:	74 11                	je     0x3061
    3050:	b0 e8                	mov    $0xe8,%al
    3052:	e6 64                	out    %al,$0x64
    3054:	b8 ff 00             	mov    $0xff,%ax
    3057:	e8 e8 fe             	call   0x2f42
    305a:	e8 a4 ff             	call   0x3001
    305d:	73 07                	jae    0x3066
    305f:	3c fb                	cmp    $0xfb,%al
    3061:	75 03                	jne    0x3066
    3063:	80 cd 08             	or     $0x8,%ch
    3066:	b0 e2                	mov    $0xe2,%al
    3068:	e6 64                	out    %al,$0x64
    306a:	e9 00 00             	jmp    0x306d
    306d:	80 e5 ef             	and    $0xef,%ch
    3070:	8b d1                	mov    %cx,%dx
    3072:	b0 96                	mov    $0x96,%al
    3074:	e6 5e                	out    %al,$0x5e
    3076:	b0 64                	mov    $0x64,%al
    3078:	e6 5c                	out    %al,$0x5c
    307a:	b9 36 00             	mov    $0x36,%cx
    307d:	d2 e5                	shl    %cl,%ch
    307f:	b0 80                	mov    $0x80,%al
    3081:	e6 5e                	out    %al,$0x5e
    3083:	e4 5c                	in     $0x5c,%al
    3085:	3c 10                	cmp    $0x10,%al
    3087:	7f 03                	jg     0x308c
    3089:	80 ce 10             	or     $0x10,%dh
    308c:	8b ca                	mov    %dx,%cx
    308e:	b0 96                	mov    $0x96,%al
    3090:	e6 5e                	out    %al,$0x5e
    3092:	b0 0d                	mov    $0xd,%al
    3094:	e6 5c                	out    %al,$0x5c
    3096:	8b d1                	mov    %cx,%dx
    3098:	33 c0                	xor    %ax,%ax
    309a:	8e c0                	mov    %ax,%es
    309c:	bb 58 01             	mov    $0x158,%bx
    309f:	26 c7 07 35 20       	movw   $0x2035,%es:(%bx)
    30a4:	26 c7 47 02 10 fd    	movw   $0xfd10,%es:0x2(%bx)
    30aa:	b0 10                	mov    $0x10,%al
    30ac:	e6 5e                	out    %al,$0x5e
    30ae:	b0 bf                	mov    $0xbf,%al
    30b0:	e6 02                	out    %al,$0x2
    30b2:	b9 ff ff             	mov    $0xffff,%cx
    30b5:	b0 0a                	mov    $0xa,%al
    30b7:	e6 58                	out    %al,$0x58
    30b9:	33 c0                	xor    %ax,%ax
    30bb:	fb                   	sti    
    30bc:	3c 00                	cmp    $0x0,%al
    30be:	e1 fc                	loope  0x30bc
    30c0:	8b ca                	mov    %dx,%cx
    30c2:	75 07                	jne    0x30cb
    30c4:	b0 ff                	mov    $0xff,%al
    30c6:	e6 02                	out    %al,$0x2
    30c8:	80 e5 df             	and    $0xdf,%ch
    30cb:	fa                   	cli    
    30cc:	33 c0                	xor    %ax,%ax
    30ce:	8e d8                	mov    %ax,%ds
    30d0:	8b d8                	mov    %ax,%bx
    30d2:	b8 01 ff             	mov    $0xff01,%ax
    30d5:	89 07                	mov    %ax,(%bx)
    30d7:	33 c0                	xor    %ax,%ax
    30d9:	89 47 02             	mov    %ax,0x2(%bx)
    30dc:	b8 50 00             	mov    $0x50,%ax
    30df:	89 47 04             	mov    %ax,0x4(%bx)
    30e2:	bb 00 05             	mov    $0x500,%bx
    30e5:	ba 00 01             	mov    $0x100,%dx
    30e8:	b8 ee ee             	mov    $0xeeee,%ax
    30eb:	89 07                	mov    %ax,(%bx)
    30ed:	e6 72                	out    %al,$0x72
    30ef:	8a 47 01             	mov    0x1(%bx),%al
    30f2:	3c 00                	cmp    $0x0,%al
    30f4:	74 06                	je     0x30fc
    30f6:	4a                   	dec    %dx
    30f7:	75 f6                	jne    0x30ef
    30f9:	e9 05 00             	jmp    0x3101
    30fc:	e8 41 00             	call   0x3140
    30ff:	74 1a                	je     0x311b
    3101:	80 e5 bf             	and    $0xbf,%ch
    3104:	8b d1                	mov    %cx,%dx
    3106:	b8 00 fc             	mov    $0xfc00,%ax
    3109:	8e d8                	mov    %ax,%ds
    310b:	b8 00 3f             	mov    $0x3f00,%ax
    310e:	8e c0                	mov    %ax,%es
    3110:	b9 00 04             	mov    $0x400,%cx
    3113:	33 f6                	xor    %si,%si
    3115:	8b fe                	mov    %si,%di
    3117:	f3 a5                	rep movsw %ds:(%si),%es:(%di)
    3119:	8b ca                	mov    %dx,%cx
    311b:	80 cd 80             	or     $0x80,%ch
    311e:	33 c0                	xor    %ax,%ax
    3120:	8e c0                	mov    %ax,%es
    3122:	83 fd 00             	cmp    $0x0,%bp
    3125:	75 03                	jne    0x312a
    3127:	80 e5 7f             	and    $0x7f,%ch
    312a:	bb 20 04             	mov    $0x420,%bx
    312d:	26 89 0f             	mov    %cx,%es:(%bx)
    3130:	ea 00 00 10 fd       	ljmp   $0xfd10,$0x0
    3135:	b0 ff                	mov    $0xff,%al
    3137:	e6 58                	out    %al,$0x58
    3139:	e6 02                	out    %al,$0x2
    313b:	b0 20                	mov    $0x20,%al
    313d:	e6 00                	out    %al,$0x0
    313f:	cf                   	iret   
    3140:	33 c0                	xor    %ax,%ax
    3142:	8e d8                	mov    %ax,%ds
    3144:	bb 00 05             	mov    $0x500,%bx
    3147:	8c 4f 04             	mov    %cs,0x4(%bx)
    314a:	c7 47 02 64 20       	movw   $0x2064,0x2(%bx)
    314f:	c7 07 03 ee          	movw   $0xee03,(%bx)
    3153:	e6 70                	out    %al,$0x70
    3155:	b8 ff ff             	mov    $0xffff,%ax
    3158:	8a 47 01             	mov    0x1(%bx),%al
    315b:	74 29                	je     0x3186
    315d:	48                   	dec    %ax
    315e:	75 f8                	jne    0x3158
    3160:	40                   	inc    %ax
    3161:	e9 38 00             	jmp    0x319c
    3164:	70 f1                	jo     0x3157
    3166:	00 f0                	add    %dh,%al
    3168:	00 c0                	add    %al,%al
    316a:	00 f0                	add    %dh,%al
    316c:	00 f0                	add    %dh,%al
    316e:	00 30                	add    %dh,(%bx,%si)
    3170:	03 8b 04 23          	add    0x2304(%bp,%di),%cx
    3174:	8b 08                	mov    (%bx,%si),%cx
    3176:	71 30                	jno    0x31a8
    3178:	00 08                	add    %cl,(%bx,%si)
    317a:	d1 30                	shlw   (%bx,%si)
    317c:	08 c0                	or     %al,%al
    317e:	80 00 60             	addb   $0x60,(%bx,%si)
    3181:	00 00                	add    %al,(%bx,%si)
    3183:	00 20                	add    %ah,(%bx,%si)
    3185:	48                   	dec    %ax
    3186:	fc                   	cld    
    3187:	8b d1                	mov    %cx,%dx
    3189:	b8 00 fc             	mov    $0xfc00,%ax
    318c:	8e d8                	mov    %ax,%ds
    318e:	b8 00 3f             	mov    $0x3f00,%ax
    3191:	8e c0                	mov    %ax,%es
    3193:	33 f6                	xor    %si,%si
    3195:	8b fe                	mov    %si,%di
    3197:	b9 00 04             	mov    $0x400,%cx
    319a:	f3 a7                	repz cmpsw %es:(%di),%ds:(%si)
    319c:	8b ca                	mov    %dx,%cx
    319e:	c3                   	ret    
    319f:	8c da                	mov    %ds,%dx
    31a1:	8b dc                	mov    %sp,%bx
    31a3:	8b 4f 02             	mov    0x2(%bx),%cx
    31a6:	c4 7f 04             	les    0x4(%bx),%di
    31a9:	c5 77 08             	lds    0x8(%bx),%si
    31ac:	fc                   	cld    
    31ad:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    31af:	8e c2                	mov    %dx,%es
    31b1:	8e da                	mov    %dx,%ds
    31b3:	c2 0a 00             	ret    $0xa
    31b6:	8c da                	mov    %ds,%dx
    31b8:	8b dc                	mov    %sp,%bx
    31ba:	8b 4f 02             	mov    0x2(%bx),%cx
    31bd:	8b 7f 04             	mov    0x4(%bx),%di
    31c0:	c5 77 06             	lds    0x6(%bx),%si
    31c3:	fc                   	cld    
    31c4:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    31c6:	8e da                	mov    %dx,%ds
    31c8:	c2 08 00             	ret    $0x8
    31cb:	8c c2                	mov    %es,%dx
    31cd:	8b dc                	mov    %sp,%bx
    31cf:	8b 4f 02             	mov    0x2(%bx),%cx
    31d2:	c4 7f 04             	les    0x4(%bx),%di
    31d5:	8b 77 08             	mov    0x8(%bx),%si
    31d8:	fc                   	cld    
    31d9:	f3 a4                	rep movsb %ds:(%si),%es:(%di)
    31db:	8e c2                	mov    %dx,%es
    31dd:	c2 08 00             	ret    $0x8
    31e0:	fa                   	cli    
    31e1:	eb fd                	jmp    0x31e0
    31e3:	55                   	push   %bp
    31e4:	8b ec                	mov    %sp,%bp
    31e6:	83 7e 04 00          	cmpw   $0x0,0x4(%bp)
    31ea:	74 70                	je     0x325c
    31ec:	83 7e 04 0a          	cmpw   $0xa,0x4(%bp)
    31f0:	77 6a                	ja     0x325c
    31f2:	8b 46 08             	mov    0x8(%bp),%ax
    31f5:	8b 4e 06             	mov    0x6(%bp),%cx
    31f8:	80 e1 0f             	and    $0xf,%cl
    31fb:	83 7e 04 06          	cmpw   $0x6,0x4(%bp)
    31ff:	7d 31                	jge    0x3232
    3201:	80 e1 07             	and    $0x7,%cl
    3204:	32 e4                	xor    %ah,%ah
    3206:	83 7e 04 01          	cmpw   $0x1,0x4(%bp)
    320a:	75 04                	jne    0x3210
    320c:	d2 e0                	shl    %cl,%al
    320e:	eb 4c                	jmp    0x325c
    3210:	83 7e 04 02          	cmpw   $0x2,0x4(%bp)
    3214:	75 04                	jne    0x321a
    3216:	d2 e8                	shr    %cl,%al
    3218:	eb 42                	jmp    0x325c
    321a:	83 7e 04 03          	cmpw   $0x3,0x4(%bp)
    321e:	75 04                	jne    0x3224
    3220:	d2 f8                	sar    %cl,%al
    3222:	eb 38                	jmp    0x325c
    3224:	83 7e 04 04          	cmpw   $0x4,0x4(%bp)
    3228:	75 04                	jne    0x322e
    322a:	d2 c0                	rol    %cl,%al
    322c:	eb 2e                	jmp    0x325c
    322e:	d2 c8                	ror    %cl,%al
    3230:	eb 2a                	jmp    0x325c
    3232:	83 7e 04 06          	cmpw   $0x6,0x4(%bp)
    3236:	75 04                	jne    0x323c
    3238:	d3 e0                	shl    %cl,%ax
    323a:	eb 20                	jmp    0x325c
    323c:	83 7e 04 07          	cmpw   $0x7,0x4(%bp)
    3240:	75 04                	jne    0x3246
    3242:	d3 e8                	shr    %cl,%ax
    3244:	eb 16                	jmp    0x325c
    3246:	83 7e 04 08          	cmpw   $0x8,0x4(%bp)
    324a:	75 04                	jne    0x3250
    324c:	d3 f8                	sar    %cl,%ax
    324e:	eb 0c                	jmp    0x325c
    3250:	83 7e 04 09          	cmpw   $0x9,0x4(%bp)
    3254:	75 04                	jne    0x325a
    3256:	d3 c0                	rol    %cl,%ax
    3258:	eb 02                	jmp    0x325c
    325a:	d3 c8                	ror    %cl,%ax
    325c:	5d                   	pop    %bp
    325d:	c2 06 00             	ret    $0x6
    3260:	55                   	push   %bp
    3261:	8b ec                	mov    %sp,%bp
    3263:	b8 cb 00             	mov    $0xcb,%ax
    3266:	50                   	push   %ax
    3267:	8a 66 04             	mov    0x4(%bp),%ah
    326a:	b0 cd                	mov    $0xcd,%al
    326c:	50                   	push   %ax
    326d:	8b dc                	mov    %sp,%bx
    326f:	0e                   	push   %cs
    3270:	8d 06 78 21          	lea    0x2178,%ax
    3274:	50                   	push   %ax
    3275:	16                   	push   %ss
    3276:	53                   	push   %bx
    3277:	cb                   	lret   
    3278:	83 c4 04             	add    $0x4,%sp
    327b:	5d                   	pop    %bp
    327c:	c2 02 00             	ret    $0x2
    327f:	fa                   	cli    
    3280:	c3                   	ret    
    3281:	fb                   	sti    
    3282:	c3                   	ret    
    3283:	f4                   	hlt    
    3284:	c3                   	ret    
    3285:	ff                   	(bad)  
    3286:	ff                   	(bad)  
    3287:	ff                   	(bad)  
    3288:	ff                   	(bad)  
    3289:	ff                   	(bad)  
    328a:	ff                   	(bad)  
    328b:	ff                   	(bad)  
    328c:	ff                   	(bad)  
    328d:	ff                   	(bad)  
    328e:	ff                   	(bad)  
    328f:	ff                   	(bad)  
    3290:	ff                   	(bad)  
    3291:	ff                   	(bad)  
    3292:	ff                   	(bad)  
    3293:	ff                   	(bad)  
    3294:	ff                   	(bad)  
    3295:	ff                   	(bad)  
    3296:	ff                   	(bad)  
    3297:	ff                   	(bad)  
    3298:	ff                   	(bad)  
    3299:	ff                   	(bad)  
    329a:	ff                   	(bad)  
    329b:	ff                   	(bad)  
    329c:	ff                   	(bad)  
    329d:	ff                   	(bad)  
    329e:	ff                   	(bad)  
    329f:	ff                   	(bad)  
    32a0:	ff                   	(bad)  
    32a1:	ff                   	(bad)  
    32a2:	ff                   	(bad)  
    32a3:	ff                   	(bad)  
    32a4:	ff                   	(bad)  
    32a5:	ff                   	(bad)  
    32a6:	ff                   	(bad)  
    32a7:	ff                   	(bad)  
    32a8:	ff                   	(bad)  
    32a9:	ff                   	(bad)  
    32aa:	ff                   	(bad)  
    32ab:	ff                   	(bad)  
    32ac:	ff                   	(bad)  
    32ad:	ff                   	(bad)  
    32ae:	ff                   	(bad)  
    32af:	ff                   	(bad)  
    32b0:	ff                   	(bad)  
    32b1:	ff                   	(bad)  
    32b2:	ff                   	(bad)  
    32b3:	ff                   	(bad)  
    32b4:	ff                   	(bad)  
    32b5:	ff                   	(bad)  
    32b6:	ff                   	(bad)  
    32b7:	ff                   	(bad)  
    32b8:	ff                   	(bad)  
    32b9:	ff                   	(bad)  
    32ba:	ff                   	(bad)  
    32bb:	ff                   	(bad)  
    32bc:	ff                   	(bad)  
    32bd:	ff                   	(bad)  
    32be:	ff                   	(bad)  
    32bf:	ff                   	(bad)  
    32c0:	ff                   	(bad)  
    32c1:	ff                   	(bad)  
    32c2:	ff                   	(bad)  
    32c3:	ff                   	(bad)  
    32c4:	ff                   	(bad)  
    32c5:	ff                   	(bad)  
    32c6:	ff                   	(bad)  
    32c7:	ff                   	(bad)  
    32c8:	ff                   	(bad)  
    32c9:	ff                   	(bad)  
    32ca:	ff                   	(bad)  
    32cb:	ff                   	(bad)  
    32cc:	ff                   	(bad)  
    32cd:	ff                   	(bad)  
    32ce:	ff                   	(bad)  
    32cf:	ff                   	(bad)  
    32d0:	ff                   	(bad)  
    32d1:	ff                   	(bad)  
    32d2:	ff                   	(bad)  
    32d3:	ff                   	(bad)  
    32d4:	ff                   	(bad)  
    32d5:	ff                   	(bad)  
    32d6:	ff                   	(bad)  
    32d7:	ff                   	(bad)  
    32d8:	ff                   	(bad)  
    32d9:	ff                   	(bad)  
    32da:	ff                   	(bad)  
    32db:	ff                   	(bad)  
    32dc:	ff                   	(bad)  
    32dd:	ff                   	(bad)  
    32de:	ff                   	(bad)  
    32df:	ff                   	(bad)  
    32e0:	ff                   	(bad)  
    32e1:	ff                   	(bad)  
    32e2:	ff                   	(bad)  
    32e3:	ff                   	(bad)  
    32e4:	ff                   	(bad)  
    32e5:	ff                   	(bad)  
    32e6:	ff                   	(bad)  
    32e7:	ff                   	(bad)  
    32e8:	ff                   	(bad)  
    32e9:	ff                   	(bad)  
    32ea:	ff                   	(bad)  
    32eb:	ff                   	(bad)  
    32ec:	ff                   	(bad)  
    32ed:	ff                   	(bad)  
    32ee:	ff                   	(bad)  
    32ef:	ff                   	(bad)  
    32f0:	ff                   	(bad)  
    32f1:	ff                   	(bad)  
    32f2:	ff                   	(bad)  
    32f3:	ff                   	(bad)  
    32f4:	ff                   	(bad)  
    32f5:	ff                   	(bad)  
    32f6:	ff                   	(bad)  
    32f7:	ff                   	(bad)  
    32f8:	ff                   	(bad)  
    32f9:	ff                   	(bad)  
    32fa:	ff                   	(bad)  
    32fb:	ff                   	(bad)  
    32fc:	ff                   	(bad)  
    32fd:	ff                   	(bad)  
    32fe:	ff                   	(bad)  
    32ff:	ff                   	(bad)  
    3300:	ff                   	(bad)  
    3301:	ff                   	(bad)  
    3302:	ff                   	(bad)  
    3303:	ff                   	(bad)  
    3304:	ff                   	(bad)  
    3305:	ff                   	(bad)  
    3306:	ff                   	(bad)  
    3307:	ff                   	(bad)  
    3308:	ff                   	(bad)  
    3309:	ff                   	(bad)  
    330a:	ff                   	(bad)  
    330b:	ff                   	(bad)  
    330c:	ff                   	(bad)  
    330d:	ff                   	(bad)  
    330e:	ff                   	(bad)  
    330f:	ff                   	(bad)  
    3310:	ff                   	(bad)  
    3311:	ff                   	(bad)  
    3312:	ff                   	(bad)  
    3313:	ff                   	(bad)  
    3314:	ff                   	(bad)  
    3315:	ff                   	(bad)  
    3316:	ff                   	(bad)  
    3317:	ff                   	(bad)  
    3318:	ff                   	(bad)  
    3319:	ff                   	(bad)  
    331a:	ff                   	(bad)  
    331b:	ff                   	(bad)  
    331c:	ff                   	(bad)  
    331d:	ff                   	(bad)  
    331e:	ff                   	(bad)  
    331f:	ff                   	(bad)  
    3320:	ff                   	(bad)  
    3321:	ff                   	(bad)  
    3322:	ff                   	(bad)  
    3323:	ff                   	(bad)  
    3324:	ff                   	(bad)  
    3325:	ff                   	(bad)  
    3326:	ff                   	(bad)  
    3327:	ff                   	(bad)  
    3328:	ff                   	(bad)  
    3329:	ff                   	(bad)  
    332a:	ff                   	(bad)  
    332b:	ff                   	(bad)  
    332c:	ff                   	(bad)  
    332d:	ff                   	(bad)  
    332e:	ff                   	(bad)  
    332f:	ff                   	(bad)  
    3330:	ff                   	(bad)  
    3331:	ff                   	(bad)  
    3332:	ff                   	(bad)  
    3333:	ff                   	(bad)  
    3334:	ff                   	(bad)  
    3335:	ff                   	(bad)  
    3336:	ff                   	(bad)  
    3337:	ff                   	(bad)  
    3338:	ff                   	(bad)  
    3339:	ff                   	(bad)  
    333a:	ff                   	(bad)  
    333b:	ff                   	(bad)  
    333c:	ff                   	(bad)  
    333d:	ff                   	(bad)  
    333e:	ff                   	(bad)  
    333f:	ff                   	(bad)  
    3340:	ff                   	(bad)  
    3341:	ff                   	(bad)  
    3342:	ff                   	(bad)  
    3343:	ff                   	(bad)  
    3344:	ff                   	(bad)  
    3345:	ff                   	(bad)  
    3346:	ff                   	(bad)  
    3347:	ff                   	(bad)  
    3348:	ff                   	(bad)  
    3349:	ff                   	(bad)  
    334a:	ff                   	(bad)  
    334b:	ff                   	(bad)  
    334c:	ff                   	(bad)  
    334d:	ff                   	(bad)  
    334e:	ff                   	(bad)  
    334f:	ff                   	(bad)  
    3350:	ff                   	(bad)  
    3351:	ff                   	(bad)  
    3352:	ff                   	(bad)  
    3353:	ff                   	(bad)  
    3354:	ff                   	(bad)  
    3355:	ff                   	(bad)  
    3356:	ff                   	(bad)  
    3357:	ff                   	(bad)  
    3358:	ff                   	(bad)  
    3359:	ff                   	(bad)  
    335a:	ff                   	(bad)  
    335b:	ff                   	(bad)  
    335c:	ff                   	(bad)  
    335d:	ff                   	(bad)  
    335e:	ff                   	(bad)  
    335f:	ff                   	(bad)  
    3360:	ff                   	(bad)  
    3361:	ff                   	(bad)  
    3362:	ff                   	(bad)  
    3363:	ff                   	(bad)  
    3364:	ff                   	(bad)  
    3365:	ff                   	(bad)  
    3366:	ff                   	(bad)  
    3367:	ff                   	(bad)  
    3368:	ff                   	(bad)  
    3369:	ff                   	(bad)  
    336a:	ff                   	(bad)  
    336b:	ff                   	(bad)  
    336c:	ff                   	(bad)  
    336d:	ff                   	(bad)  
    336e:	ff                   	(bad)  
    336f:	ff                   	(bad)  
    3370:	ff                   	(bad)  
    3371:	ff                   	(bad)  
    3372:	ff                   	(bad)  
    3373:	ff                   	(bad)  
    3374:	ff                   	(bad)  
    3375:	ff                   	(bad)  
    3376:	ff                   	(bad)  
    3377:	ff                   	(bad)  
    3378:	ff                   	(bad)  
    3379:	ff                   	(bad)  
    337a:	ff                   	(bad)  
    337b:	ff                   	(bad)  
    337c:	ff                   	(bad)  
    337d:	ff                   	(bad)  
    337e:	ff                   	(bad)  
    337f:	ff                   	(bad)  
    3380:	ff                   	(bad)  
    3381:	ff                   	(bad)  
    3382:	ff                   	(bad)  
    3383:	ff                   	(bad)  
    3384:	ff                   	(bad)  
    3385:	ff                   	(bad)  
    3386:	ff                   	(bad)  
    3387:	ff                   	(bad)  
    3388:	ff                   	(bad)  
    3389:	ff                   	(bad)  
    338a:	ff                   	(bad)  
    338b:	ff                   	(bad)  
    338c:	ff                   	(bad)  
    338d:	ff                   	(bad)  
    338e:	ff                   	(bad)  
    338f:	ff                   	(bad)  
    3390:	ff                   	(bad)  
    3391:	ff                   	(bad)  
    3392:	ff                   	(bad)  
    3393:	ff                   	(bad)  
    3394:	ff                   	(bad)  
    3395:	ff                   	(bad)  
    3396:	ff                   	(bad)  
    3397:	ff                   	(bad)  
    3398:	ff                   	(bad)  
    3399:	ff                   	(bad)  
    339a:	ff                   	(bad)  
    339b:	ff                   	(bad)  
    339c:	ff                   	(bad)  
    339d:	ff                   	(bad)  
    339e:	ff                   	(bad)  
    339f:	ff                   	(bad)  
    33a0:	ff                   	(bad)  
    33a1:	ff                   	(bad)  
    33a2:	ff                   	(bad)  
    33a3:	ff                   	(bad)  
    33a4:	ff                   	(bad)  
    33a5:	ff                   	(bad)  
    33a6:	ff                   	(bad)  
    33a7:	ff                   	(bad)  
    33a8:	ff                   	(bad)  
    33a9:	ff                   	(bad)  
    33aa:	ff                   	(bad)  
    33ab:	ff                   	(bad)  
    33ac:	ff                   	(bad)  
    33ad:	ff                   	(bad)  
    33ae:	ff                   	(bad)  
    33af:	ff                   	(bad)  
    33b0:	ff                   	(bad)  
    33b1:	ff                   	(bad)  
    33b2:	ff                   	(bad)  
    33b3:	ff                   	(bad)  
    33b4:	ff                   	(bad)  
    33b5:	ff                   	(bad)  
    33b6:	ff                   	(bad)  
    33b7:	ff                   	(bad)  
    33b8:	ff                   	(bad)  
    33b9:	ff                   	(bad)  
    33ba:	ff                   	(bad)  
    33bb:	ff                   	(bad)  
    33bc:	ff                   	(bad)  
    33bd:	ff                   	(bad)  
    33be:	ff                   	(bad)  
    33bf:	ff                   	(bad)  
    33c0:	ff                   	(bad)  
    33c1:	ff                   	(bad)  
    33c2:	ff                   	(bad)  
    33c3:	ff                   	(bad)  
    33c4:	ff                   	(bad)  
    33c5:	ff                   	(bad)  
    33c6:	ff                   	(bad)  
    33c7:	ff                   	(bad)  
    33c8:	ff                   	(bad)  
    33c9:	ff                   	(bad)  
    33ca:	ff                   	(bad)  
    33cb:	ff                   	(bad)  
    33cc:	ff                   	(bad)  
    33cd:	ff                   	(bad)  
    33ce:	ff                   	(bad)  
    33cf:	ff                   	(bad)  
    33d0:	ff                   	(bad)  
    33d1:	ff                   	(bad)  
    33d2:	ff                   	(bad)  
    33d3:	ff                   	(bad)  
    33d4:	ff                   	(bad)  
    33d5:	ff                   	(bad)  
    33d6:	ff                   	(bad)  
    33d7:	ff                   	(bad)  
    33d8:	ff                   	(bad)  
    33d9:	ff                   	(bad)  
    33da:	ff                   	(bad)  
    33db:	ff                   	(bad)  
    33dc:	ff                   	(bad)  
    33dd:	ff                   	(bad)  
    33de:	ff                   	(bad)  
    33df:	ff                   	(bad)  
    33e0:	ff                   	(bad)  
    33e1:	ff                   	(bad)  
    33e2:	ff                   	(bad)  
    33e3:	ff                   	(bad)  
    33e4:	ff                   	(bad)  
    33e5:	ff                   	(bad)  
    33e6:	ff                   	(bad)  
    33e7:	ff                   	(bad)  
    33e8:	ff                   	(bad)  
    33e9:	ff                   	(bad)  
    33ea:	ff                   	(bad)  
    33eb:	ff                   	(bad)  
    33ec:	ff                   	(bad)  
    33ed:	ff                   	(bad)  
    33ee:	ff                   	(bad)  
    33ef:	ff                   	(bad)  
    33f0:	ff                   	(bad)  
    33f1:	ff                   	(bad)  
    33f2:	ff                   	(bad)  
    33f3:	ff                   	(bad)  
    33f4:	ff                   	(bad)  
    33f5:	ff                   	(bad)  
    33f6:	ff                   	(bad)  
    33f7:	ff                   	(bad)  
    33f8:	ff                   	(bad)  
    33f9:	ff                   	(bad)  
    33fa:	ff                   	(bad)  
    33fb:	ff                   	(bad)  
    33fc:	ff                   	(bad)  
    33fd:	ff                   	(bad)  
    33fe:	ff                   	(bad)  
    33ff:	ff                   	(bad)  
    3400:	ff                   	(bad)  
    3401:	ff                   	(bad)  
    3402:	ff                   	(bad)  
    3403:	ff                   	(bad)  
    3404:	ff                   	(bad)  
    3405:	ff                   	(bad)  
    3406:	ff                   	(bad)  
    3407:	ff                   	(bad)  
    3408:	ff                   	(bad)  
    3409:	ff                   	(bad)  
    340a:	ff                   	(bad)  
    340b:	ff                   	(bad)  
    340c:	ff                   	(bad)  
    340d:	ff                   	(bad)  
    340e:	ff                   	(bad)  
    340f:	ff                   	(bad)  
    3410:	ff                   	(bad)  
    3411:	ff                   	(bad)  
    3412:	ff                   	(bad)  
    3413:	ff                   	(bad)  
    3414:	ff                   	(bad)  
    3415:	ff                   	(bad)  
    3416:	ff                   	(bad)  
    3417:	ff                   	(bad)  
    3418:	ff                   	(bad)  
    3419:	ff                   	(bad)  
    341a:	ff                   	(bad)  
    341b:	ff                   	(bad)  
    341c:	ff                   	(bad)  
    341d:	ff                   	(bad)  
    341e:	ff                   	(bad)  
    341f:	ff                   	(bad)  
    3420:	ff                   	(bad)  
    3421:	ff                   	(bad)  
    3422:	ff                   	(bad)  
    3423:	ff                   	(bad)  
    3424:	ff                   	(bad)  
    3425:	ff                   	(bad)  
    3426:	ff                   	(bad)  
    3427:	ff                   	(bad)  
    3428:	ff                   	(bad)  
    3429:	ff                   	(bad)  
    342a:	ff                   	(bad)  
    342b:	ff                   	(bad)  
    342c:	ff                   	(bad)  
    342d:	ff                   	(bad)  
    342e:	ff                   	(bad)  
    342f:	ff                   	(bad)  
    3430:	ff                   	(bad)  
    3431:	ff                   	(bad)  
    3432:	ff                   	(bad)  
    3433:	ff                   	(bad)  
    3434:	ff                   	(bad)  
    3435:	ff                   	(bad)  
    3436:	ff                   	(bad)  
    3437:	ff                   	(bad)  
    3438:	ff                   	(bad)  
    3439:	ff                   	(bad)  
    343a:	ff                   	(bad)  
    343b:	ff                   	(bad)  
    343c:	ff                   	(bad)  
    343d:	ff                   	(bad)  
    343e:	ff                   	(bad)  
    343f:	ff                   	(bad)  
    3440:	ff                   	(bad)  
    3441:	ff                   	(bad)  
    3442:	ff                   	(bad)  
    3443:	ff                   	(bad)  
    3444:	ff                   	(bad)  
    3445:	ff                   	(bad)  
    3446:	ff                   	(bad)  
    3447:	ff                   	(bad)  
    3448:	ff                   	(bad)  
    3449:	ff                   	(bad)  
    344a:	ff                   	(bad)  
    344b:	ff                   	(bad)  
    344c:	ff                   	(bad)  
    344d:	ff                   	(bad)  
    344e:	ff                   	(bad)  
    344f:	ff                   	(bad)  
    3450:	ff                   	(bad)  
    3451:	ff                   	(bad)  
    3452:	ff                   	(bad)  
    3453:	ff                   	(bad)  
    3454:	ff                   	(bad)  
    3455:	ff                   	(bad)  
    3456:	ff                   	(bad)  
    3457:	ff                   	(bad)  
    3458:	ff                   	(bad)  
    3459:	ff                   	(bad)  
    345a:	ff                   	(bad)  
    345b:	ff                   	(bad)  
    345c:	ff                   	(bad)  
    345d:	ff                   	(bad)  
    345e:	ff                   	(bad)  
    345f:	ff                   	(bad)  
    3460:	ff                   	(bad)  
    3461:	ff                   	(bad)  
    3462:	ff                   	(bad)  
    3463:	ff                   	(bad)  
    3464:	ff                   	(bad)  
    3465:	ff                   	(bad)  
    3466:	ff                   	(bad)  
    3467:	ff                   	(bad)  
    3468:	ff                   	(bad)  
    3469:	ff                   	(bad)  
    346a:	ff                   	(bad)  
    346b:	ff                   	(bad)  
    346c:	ff                   	(bad)  
    346d:	ff                   	(bad)  
    346e:	ff                   	(bad)  
    346f:	ff                   	(bad)  
    3470:	ff                   	(bad)  
    3471:	ff                   	(bad)  
    3472:	ff                   	(bad)  
    3473:	ff                   	(bad)  
    3474:	ff                   	(bad)  
    3475:	ff                   	(bad)  
    3476:	ff                   	(bad)  
    3477:	ff                   	(bad)  
    3478:	ff                   	(bad)  
    3479:	ff                   	(bad)  
    347a:	ff                   	(bad)  
    347b:	ff                   	(bad)  
    347c:	ff                   	(bad)  
    347d:	ff                   	(bad)  
    347e:	ff                   	(bad)  
    347f:	ff                   	(bad)  
    3480:	ff                   	(bad)  
    3481:	ff                   	(bad)  
    3482:	ff                   	(bad)  
    3483:	ff                   	(bad)  
    3484:	ff                   	(bad)  
    3485:	ff                   	(bad)  
    3486:	ff                   	(bad)  
    3487:	ff                   	(bad)  
    3488:	ff                   	(bad)  
    3489:	ff                   	(bad)  
    348a:	ff                   	(bad)  
    348b:	ff                   	(bad)  
    348c:	ff                   	(bad)  
    348d:	ff                   	(bad)  
    348e:	ff                   	(bad)  
    348f:	ff                   	(bad)  
    3490:	ff                   	(bad)  
    3491:	ff                   	(bad)  
    3492:	ff                   	(bad)  
    3493:	ff                   	(bad)  
    3494:	ff                   	(bad)  
    3495:	ff                   	(bad)  
    3496:	ff                   	(bad)  
    3497:	ff                   	(bad)  
    3498:	ff                   	(bad)  
    3499:	ff                   	(bad)  
    349a:	ff                   	(bad)  
    349b:	ff                   	(bad)  
    349c:	ff                   	(bad)  
    349d:	ff                   	(bad)  
    349e:	ff                   	(bad)  
    349f:	ff                   	(bad)  
    34a0:	ff                   	(bad)  
    34a1:	ff                   	(bad)  
    34a2:	ff                   	(bad)  
    34a3:	ff                   	(bad)  
    34a4:	ff                   	(bad)  
    34a5:	ff                   	(bad)  
    34a6:	ff                   	(bad)  
    34a7:	ff                   	(bad)  
    34a8:	ff                   	(bad)  
    34a9:	ff                   	(bad)  
    34aa:	ff                   	(bad)  
    34ab:	ff                   	(bad)  
    34ac:	ff                   	(bad)  
    34ad:	ff                   	(bad)  
    34ae:	ff                   	(bad)  
    34af:	ff                   	(bad)  
    34b0:	ff                   	(bad)  
    34b1:	ff                   	(bad)  
    34b2:	ff                   	(bad)  
    34b3:	ff                   	(bad)  
    34b4:	ff                   	(bad)  
    34b5:	ff                   	(bad)  
    34b6:	ff                   	(bad)  
    34b7:	ff                   	(bad)  
    34b8:	ff                   	(bad)  
    34b9:	ff                   	(bad)  
    34ba:	ff                   	(bad)  
    34bb:	ff                   	(bad)  
    34bc:	ff                   	(bad)  
    34bd:	ff                   	(bad)  
    34be:	ff                   	(bad)  
    34bf:	ff                   	(bad)  
    34c0:	ff                   	(bad)  
    34c1:	ff                   	(bad)  
    34c2:	ff                   	(bad)  
    34c3:	ff                   	(bad)  
    34c4:	ff                   	(bad)  
    34c5:	ff                   	(bad)  
    34c6:	ff                   	(bad)  
    34c7:	ff                   	(bad)  
    34c8:	ff                   	(bad)  
    34c9:	ff                   	(bad)  
    34ca:	ff                   	(bad)  
    34cb:	ff                   	(bad)  
    34cc:	ff                   	(bad)  
    34cd:	ff                   	(bad)  
    34ce:	ff                   	(bad)  
    34cf:	ff                   	(bad)  
    34d0:	ff                   	(bad)  
    34d1:	ff                   	(bad)  
    34d2:	ff                   	(bad)  
    34d3:	ff                   	(bad)  
    34d4:	ff                   	(bad)  
    34d5:	ff                   	(bad)  
    34d6:	ff                   	(bad)  
    34d7:	ff                   	(bad)  
    34d8:	ff                   	(bad)  
    34d9:	ff                   	(bad)  
    34da:	ff                   	(bad)  
    34db:	ff                   	(bad)  
    34dc:	ff                   	(bad)  
    34dd:	ff                   	(bad)  
    34de:	ff                   	(bad)  
    34df:	ff                   	(bad)  
    34e0:	ff                   	(bad)  
    34e1:	ff                   	(bad)  
    34e2:	ff                   	(bad)  
    34e3:	ff                   	(bad)  
    34e4:	ff                   	(bad)  
    34e5:	ff                   	(bad)  
    34e6:	ff                   	(bad)  
    34e7:	ff                   	(bad)  
    34e8:	ff                   	(bad)  
    34e9:	ff                   	(bad)  
    34ea:	ff                   	(bad)  
    34eb:	ff                   	(bad)  
    34ec:	ff                   	(bad)  
    34ed:	ff                   	(bad)  
    34ee:	ff                   	(bad)  
    34ef:	ff                   	(bad)  
    34f0:	ff                   	(bad)  
    34f1:	ff                   	(bad)  
    34f2:	ff                   	(bad)  
    34f3:	ff                   	(bad)  
    34f4:	ff                   	(bad)  
    34f5:	ff                   	(bad)  
    34f6:	ff                   	(bad)  
    34f7:	ff                   	(bad)  
    34f8:	ff                   	(bad)  
    34f9:	ff                   	(bad)  
    34fa:	ff                   	(bad)  
    34fb:	ff                   	(bad)  
    34fc:	ff                   	(bad)  
    34fd:	ff                   	(bad)  
    34fe:	ff                   	(bad)  
    34ff:	ff                   	(bad)  
    3500:	ff                   	(bad)  
    3501:	ff                   	(bad)  
    3502:	ff                   	(bad)  
    3503:	ff                   	(bad)  
    3504:	ff                   	(bad)  
    3505:	ff                   	(bad)  
    3506:	ff                   	(bad)  
    3507:	ff                   	(bad)  
    3508:	ff                   	(bad)  
    3509:	ff                   	(bad)  
    350a:	ff                   	(bad)  
    350b:	ff                   	(bad)  
    350c:	ff                   	(bad)  
    350d:	ff                   	(bad)  
    350e:	ff                   	(bad)  
    350f:	ff                   	(bad)  
    3510:	ff                   	(bad)  
    3511:	ff                   	(bad)  
    3512:	ff                   	(bad)  
    3513:	ff                   	(bad)  
    3514:	ff                   	(bad)  
    3515:	ff                   	(bad)  
    3516:	ff                   	(bad)  
    3517:	ff                   	(bad)  
    3518:	ff                   	(bad)  
    3519:	ff                   	(bad)  
    351a:	ff                   	(bad)  
    351b:	ff                   	(bad)  
    351c:	ff                   	(bad)  
    351d:	ff                   	(bad)  
    351e:	ff                   	(bad)  
    351f:	ff                   	(bad)  
    3520:	ff                   	(bad)  
    3521:	ff                   	(bad)  
    3522:	ff                   	(bad)  
    3523:	ff                   	(bad)  
    3524:	ff                   	(bad)  
    3525:	ff                   	(bad)  
    3526:	ff                   	(bad)  
    3527:	ff                   	(bad)  
    3528:	ff                   	(bad)  
    3529:	ff                   	(bad)  
    352a:	ff                   	(bad)  
    352b:	ff                   	(bad)  
    352c:	ff                   	(bad)  
    352d:	ff                   	(bad)  
    352e:	ff                   	(bad)  
    352f:	ff                   	(bad)  
    3530:	ff                   	(bad)  
    3531:	ff                   	(bad)  
    3532:	ff                   	(bad)  
    3533:	ff                   	(bad)  
    3534:	ff                   	(bad)  
    3535:	ff                   	(bad)  
    3536:	ff                   	(bad)  
    3537:	ff                   	(bad)  
    3538:	ff                   	(bad)  
    3539:	ff                   	(bad)  
    353a:	ff                   	(bad)  
    353b:	ff                   	(bad)  
    353c:	ff                   	(bad)  
    353d:	ff                   	(bad)  
    353e:	ff                   	(bad)  
    353f:	ff                   	(bad)  
    3540:	ff                   	(bad)  
    3541:	ff                   	(bad)  
    3542:	ff                   	(bad)  
    3543:	ff                   	(bad)  
    3544:	ff                   	(bad)  
    3545:	ff                   	(bad)  
    3546:	ff                   	(bad)  
    3547:	ff                   	(bad)  
    3548:	ff                   	(bad)  
    3549:	ff                   	(bad)  
    354a:	ff                   	(bad)  
    354b:	ff                   	(bad)  
    354c:	ff                   	(bad)  
    354d:	ff                   	(bad)  
    354e:	ff                   	(bad)  
    354f:	ff                   	(bad)  
    3550:	ff                   	(bad)  
    3551:	ff                   	(bad)  
    3552:	ff                   	(bad)  
    3553:	ff                   	(bad)  
    3554:	ff                   	(bad)  
    3555:	ff                   	(bad)  
    3556:	ff                   	(bad)  
    3557:	ff                   	(bad)  
    3558:	ff                   	(bad)  
    3559:	ff                   	(bad)  
    355a:	ff                   	(bad)  
    355b:	ff                   	(bad)  
    355c:	ff                   	(bad)  
    355d:	ff                   	(bad)  
    355e:	ff                   	(bad)  
    355f:	ff                   	(bad)  
    3560:	ff                   	(bad)  
    3561:	ff                   	(bad)  
    3562:	ff                   	(bad)  
    3563:	ff                   	(bad)  
    3564:	ff                   	(bad)  
    3565:	ff                   	(bad)  
    3566:	ff                   	(bad)  
    3567:	ff                   	(bad)  
    3568:	ff                   	(bad)  
    3569:	ff                   	(bad)  
    356a:	ff                   	(bad)  
    356b:	ff                   	(bad)  
    356c:	ff                   	(bad)  
    356d:	ff                   	(bad)  
    356e:	ff                   	(bad)  
    356f:	ff                   	(bad)  
    3570:	ff                   	(bad)  
    3571:	ff                   	(bad)  
    3572:	ff                   	(bad)  
    3573:	ff                   	(bad)  
    3574:	ff                   	(bad)  
    3575:	ff                   	(bad)  
    3576:	ff                   	(bad)  
    3577:	ff                   	(bad)  
    3578:	ff                   	(bad)  
    3579:	ff                   	(bad)  
    357a:	ff                   	(bad)  
    357b:	ff                   	(bad)  
    357c:	ff                   	(bad)  
    357d:	ff                   	(bad)  
    357e:	ff                   	(bad)  
    357f:	ff                   	(bad)  
    3580:	ff                   	(bad)  
    3581:	ff                   	(bad)  
    3582:	ff                   	(bad)  
    3583:	ff                   	(bad)  
    3584:	ff                   	(bad)  
    3585:	ff                   	(bad)  
    3586:	ff                   	(bad)  
    3587:	ff                   	(bad)  
    3588:	ff                   	(bad)  
    3589:	ff                   	(bad)  
    358a:	ff                   	(bad)  
    358b:	ff                   	(bad)  
    358c:	ff                   	(bad)  
    358d:	ff                   	(bad)  
    358e:	ff                   	(bad)  
    358f:	ff                   	(bad)  
    3590:	ff                   	(bad)  
    3591:	ff                   	(bad)  
    3592:	ff                   	(bad)  
    3593:	ff                   	(bad)  
    3594:	ff                   	(bad)  
    3595:	ff                   	(bad)  
    3596:	ff                   	(bad)  
    3597:	ff                   	(bad)  
    3598:	ff                   	(bad)  
    3599:	ff                   	(bad)  
    359a:	ff                   	(bad)  
    359b:	ff                   	(bad)  
    359c:	ff                   	(bad)  
    359d:	ff                   	(bad)  
    359e:	ff                   	(bad)  
    359f:	ff                   	(bad)  
    35a0:	ff                   	(bad)  
    35a1:	ff                   	(bad)  
    35a2:	ff                   	(bad)  
    35a3:	ff                   	(bad)  
    35a4:	ff                   	(bad)  
    35a5:	ff                   	(bad)  
    35a6:	ff                   	(bad)  
    35a7:	ff                   	(bad)  
    35a8:	ff                   	(bad)  
    35a9:	ff                   	(bad)  
    35aa:	ff                   	(bad)  
    35ab:	ff                   	(bad)  
    35ac:	ff                   	(bad)  
    35ad:	ff                   	(bad)  
    35ae:	ff                   	(bad)  
    35af:	ff                   	(bad)  
    35b0:	ff                   	(bad)  
    35b1:	ff                   	(bad)  
    35b2:	ff                   	(bad)  
    35b3:	ff                   	(bad)  
    35b4:	ff                   	(bad)  
    35b5:	ff                   	(bad)  
    35b6:	ff                   	(bad)  
    35b7:	ff                   	(bad)  
    35b8:	ff                   	(bad)  
    35b9:	ff                   	(bad)  
    35ba:	ff                   	(bad)  
    35bb:	ff                   	(bad)  
    35bc:	ff                   	(bad)  
    35bd:	ff                   	(bad)  
    35be:	ff                   	(bad)  
    35bf:	ff                   	(bad)  
    35c0:	ff                   	(bad)  
    35c1:	ff                   	(bad)  
    35c2:	ff                   	(bad)  
    35c3:	ff                   	(bad)  
    35c4:	ff                   	(bad)  
    35c5:	ff                   	(bad)  
    35c6:	ff                   	(bad)  
    35c7:	ff                   	(bad)  
    35c8:	ff                   	(bad)  
    35c9:	ff                   	(bad)  
    35ca:	ff                   	(bad)  
    35cb:	ff                   	(bad)  
    35cc:	ff                   	(bad)  
    35cd:	ff                   	(bad)  
    35ce:	ff                   	(bad)  
    35cf:	ff                   	(bad)  
    35d0:	ff                   	(bad)  
    35d1:	ff                   	(bad)  
    35d2:	ff                   	(bad)  
    35d3:	ff                   	(bad)  
    35d4:	ff                   	(bad)  
    35d5:	ff                   	(bad)  
    35d6:	ff                   	(bad)  
    35d7:	ff                   	(bad)  
    35d8:	ff                   	(bad)  
    35d9:	ff                   	(bad)  
    35da:	ff                   	(bad)  
    35db:	ff                   	(bad)  
    35dc:	ff                   	(bad)  
    35dd:	ff                   	(bad)  
    35de:	ff                   	(bad)  
    35df:	ff                   	(bad)  
    35e0:	ff                   	(bad)  
    35e1:	ff                   	(bad)  
    35e2:	ff                   	(bad)  
    35e3:	ff                   	(bad)  
    35e4:	ff                   	(bad)  
    35e5:	ff                   	(bad)  
    35e6:	ff                   	(bad)  
    35e7:	ff                   	(bad)  
    35e8:	ff                   	(bad)  
    35e9:	ff                   	(bad)  
    35ea:	ff                   	(bad)  
    35eb:	ff                   	(bad)  
    35ec:	ff                   	(bad)  
    35ed:	ff                   	(bad)  
    35ee:	ff                   	(bad)  
    35ef:	ff                   	(bad)  
    35f0:	ff                   	(bad)  
    35f1:	ff                   	(bad)  
    35f2:	ff                   	(bad)  
    35f3:	ff                   	(bad)  
    35f4:	ff                   	(bad)  
    35f5:	ff                   	(bad)  
    35f6:	ff                   	(bad)  
    35f7:	ff                   	(bad)  
    35f8:	ff                   	(bad)  
    35f9:	ff                   	(bad)  
    35fa:	ff                   	(bad)  
    35fb:	ff                   	(bad)  
    35fc:	ff                   	(bad)  
    35fd:	ff                   	(bad)  
    35fe:	ff                   	(bad)  
    35ff:	ff                   	(bad)  
    3600:	ff                   	(bad)  
    3601:	ff                   	(bad)  
    3602:	ff                   	(bad)  
    3603:	ff                   	(bad)  
    3604:	ff                   	(bad)  
    3605:	ff                   	(bad)  
    3606:	ff                   	(bad)  
    3607:	ff                   	(bad)  
    3608:	ff                   	(bad)  
    3609:	ff                   	(bad)  
    360a:	ff                   	(bad)  
    360b:	ff                   	(bad)  
    360c:	ff                   	(bad)  
    360d:	ff                   	(bad)  
    360e:	ff                   	(bad)  
    360f:	ff                   	(bad)  
    3610:	ff                   	(bad)  
    3611:	ff                   	(bad)  
    3612:	ff                   	(bad)  
    3613:	ff                   	(bad)  
    3614:	ff                   	(bad)  
    3615:	ff                   	(bad)  
    3616:	ff                   	(bad)  
    3617:	ff                   	(bad)  
    3618:	ff                   	(bad)  
    3619:	ff                   	(bad)  
    361a:	ff                   	(bad)  
    361b:	ff                   	(bad)  
    361c:	ff                   	(bad)  
    361d:	ff                   	(bad)  
    361e:	ff                   	(bad)  
    361f:	ff                   	(bad)  
    3620:	ff                   	(bad)  
    3621:	ff                   	(bad)  
    3622:	ff                   	(bad)  
    3623:	ff                   	(bad)  
    3624:	ff                   	(bad)  
    3625:	ff                   	(bad)  
    3626:	ff                   	(bad)  
    3627:	ff                   	(bad)  
    3628:	ff                   	(bad)  
    3629:	ff                   	(bad)  
    362a:	ff                   	(bad)  
    362b:	ff                   	(bad)  
    362c:	ff                   	(bad)  
    362d:	ff                   	(bad)  
    362e:	ff                   	(bad)  
    362f:	ff                   	(bad)  
    3630:	ff                   	(bad)  
    3631:	ff                   	(bad)  
    3632:	ff                   	(bad)  
    3633:	ff                   	(bad)  
    3634:	ff                   	(bad)  
    3635:	ff                   	(bad)  
    3636:	ff                   	(bad)  
    3637:	ff                   	(bad)  
    3638:	ff                   	(bad)  
    3639:	ff                   	(bad)  
    363a:	ff                   	(bad)  
    363b:	ff                   	(bad)  
    363c:	ff                   	(bad)  
    363d:	ff                   	(bad)  
    363e:	ff                   	(bad)  
    363f:	ff                   	(bad)  
    3640:	ff                   	(bad)  
    3641:	ff                   	(bad)  
    3642:	ff                   	(bad)  
    3643:	ff                   	(bad)  
    3644:	ff                   	(bad)  
    3645:	ff                   	(bad)  
    3646:	ff                   	(bad)  
    3647:	ff                   	(bad)  
    3648:	ff                   	(bad)  
    3649:	ff                   	(bad)  
    364a:	ff                   	(bad)  
    364b:	ff                   	(bad)  
    364c:	ff                   	(bad)  
    364d:	ff                   	(bad)  
    364e:	ff                   	(bad)  
    364f:	ff                   	(bad)  
    3650:	ff                   	(bad)  
    3651:	ff                   	(bad)  
    3652:	ff                   	(bad)  
    3653:	ff                   	(bad)  
    3654:	ff                   	(bad)  
    3655:	ff                   	(bad)  
    3656:	ff                   	(bad)  
    3657:	ff                   	(bad)  
    3658:	ff                   	(bad)  
    3659:	ff                   	(bad)  
    365a:	ff                   	(bad)  
    365b:	ff                   	(bad)  
    365c:	ff                   	(bad)  
    365d:	ff                   	(bad)  
    365e:	ff                   	(bad)  
    365f:	ff                   	(bad)  
    3660:	ff                   	(bad)  
    3661:	ff                   	(bad)  
    3662:	ff                   	(bad)  
    3663:	ff                   	(bad)  
    3664:	ff                   	(bad)  
    3665:	ff                   	(bad)  
    3666:	ff                   	(bad)  
    3667:	ff                   	(bad)  
    3668:	ff                   	(bad)  
    3669:	ff                   	(bad)  
    366a:	ff                   	(bad)  
    366b:	ff                   	(bad)  
    366c:	ff                   	(bad)  
    366d:	ff                   	(bad)  
    366e:	ff                   	(bad)  
    366f:	ff                   	(bad)  
    3670:	ff                   	(bad)  
    3671:	ff                   	(bad)  
    3672:	ff                   	(bad)  
    3673:	ff                   	(bad)  
    3674:	ff                   	(bad)  
    3675:	ff                   	(bad)  
    3676:	ff                   	(bad)  
    3677:	ff                   	(bad)  
    3678:	ff                   	(bad)  
    3679:	ff                   	(bad)  
    367a:	ff                   	(bad)  
    367b:	ff                   	(bad)  
    367c:	ff                   	(bad)  
    367d:	ff                   	(bad)  
    367e:	ff                   	(bad)  
    367f:	ff                   	(bad)  
    3680:	ff                   	(bad)  
    3681:	ff                   	(bad)  
    3682:	ff                   	(bad)  
    3683:	ff                   	(bad)  
    3684:	ff                   	(bad)  
    3685:	ff                   	(bad)  
    3686:	ff                   	(bad)  
    3687:	ff                   	(bad)  
    3688:	ff                   	(bad)  
    3689:	ff                   	(bad)  
    368a:	ff                   	(bad)  
    368b:	ff                   	(bad)  
    368c:	ff                   	(bad)  
    368d:	ff                   	(bad)  
    368e:	ff                   	(bad)  
    368f:	ff                   	(bad)  
    3690:	ff                   	(bad)  
    3691:	ff                   	(bad)  
    3692:	ff                   	(bad)  
    3693:	ff                   	(bad)  
    3694:	ff                   	(bad)  
    3695:	ff                   	(bad)  
    3696:	ff                   	(bad)  
    3697:	ff                   	(bad)  
    3698:	ff                   	(bad)  
    3699:	ff                   	(bad)  
    369a:	ff                   	(bad)  
    369b:	ff                   	(bad)  
    369c:	ff                   	(bad)  
    369d:	ff                   	(bad)  
    369e:	ff                   	(bad)  
    369f:	ff                   	(bad)  
    36a0:	ff                   	(bad)  
    36a1:	ff                   	(bad)  
    36a2:	ff                   	(bad)  
    36a3:	ff                   	(bad)  
    36a4:	ff                   	(bad)  
    36a5:	ff                   	(bad)  
    36a6:	ff                   	(bad)  
    36a7:	ff                   	(bad)  
    36a8:	ff                   	(bad)  
    36a9:	ff                   	(bad)  
    36aa:	ff                   	(bad)  
    36ab:	ff                   	(bad)  
    36ac:	ff                   	(bad)  
    36ad:	ff                   	(bad)  
    36ae:	ff                   	(bad)  
    36af:	ff                   	(bad)  
    36b0:	ff                   	(bad)  
    36b1:	ff                   	(bad)  
    36b2:	ff                   	(bad)  
    36b3:	ff                   	(bad)  
    36b4:	ff                   	(bad)  
    36b5:	ff                   	(bad)  
    36b6:	ff                   	(bad)  
    36b7:	ff                   	(bad)  
    36b8:	ff                   	(bad)  
    36b9:	ff                   	(bad)  
    36ba:	ff                   	(bad)  
    36bb:	ff                   	(bad)  
    36bc:	ff                   	(bad)  
    36bd:	ff                   	(bad)  
    36be:	ff                   	(bad)  
    36bf:	ff                   	(bad)  
    36c0:	ff                   	(bad)  
    36c1:	ff                   	(bad)  
    36c2:	ff                   	(bad)  
    36c3:	ff                   	(bad)  
    36c4:	ff                   	(bad)  
    36c5:	ff                   	(bad)  
    36c6:	ff                   	(bad)  
    36c7:	ff                   	(bad)  
    36c8:	ff                   	(bad)  
    36c9:	ff                   	(bad)  
    36ca:	ff                   	(bad)  
    36cb:	ff                   	(bad)  
    36cc:	ff                   	(bad)  
    36cd:	ff                   	(bad)  
    36ce:	ff                   	(bad)  
    36cf:	ff                   	(bad)  
    36d0:	ff                   	(bad)  
    36d1:	ff                   	(bad)  
    36d2:	ff                   	(bad)  
    36d3:	ff                   	(bad)  
    36d4:	ff                   	(bad)  
    36d5:	ff                   	(bad)  
    36d6:	ff                   	(bad)  
    36d7:	ff                   	(bad)  
    36d8:	ff                   	(bad)  
    36d9:	ff                   	(bad)  
    36da:	ff                   	(bad)  
    36db:	ff                   	(bad)  
    36dc:	ff                   	(bad)  
    36dd:	ff                   	(bad)  
    36de:	ff                   	(bad)  
    36df:	ff                   	(bad)  
    36e0:	ff                   	(bad)  
    36e1:	ff                   	(bad)  
    36e2:	ff                   	(bad)  
    36e3:	ff                   	(bad)  
    36e4:	ff                   	(bad)  
    36e5:	ff                   	(bad)  
    36e6:	ff                   	(bad)  
    36e7:	ff                   	(bad)  
    36e8:	ff                   	(bad)  
    36e9:	ff                   	(bad)  
    36ea:	ff                   	(bad)  
    36eb:	ff                   	(bad)  
    36ec:	ff                   	(bad)  
    36ed:	ff                   	(bad)  
    36ee:	ff                   	(bad)  
    36ef:	ff                   	(bad)  
    36f0:	ff                   	(bad)  
    36f1:	ff                   	(bad)  
    36f2:	ff                   	(bad)  
    36f3:	ff                   	(bad)  
    36f4:	ff                   	(bad)  
    36f5:	ff                   	(bad)  
    36f6:	ff                   	(bad)  
    36f7:	ff                   	(bad)  
    36f8:	ff                   	(bad)  
    36f9:	ff                   	(bad)  
    36fa:	ff                   	(bad)  
    36fb:	ff                   	(bad)  
    36fc:	ff                   	(bad)  
    36fd:	ff                   	(bad)  
    36fe:	ff                   	(bad)  
    36ff:	ff                   	(bad)  
    3700:	ff                   	(bad)  
    3701:	ff                   	(bad)  
    3702:	ff                   	(bad)  
    3703:	ff                   	(bad)  
    3704:	ff                   	(bad)  
    3705:	ff                   	(bad)  
    3706:	ff                   	(bad)  
    3707:	ff                   	(bad)  
    3708:	ff                   	(bad)  
    3709:	ff                   	(bad)  
    370a:	ff                   	(bad)  
    370b:	ff                   	(bad)  
    370c:	ff                   	(bad)  
    370d:	ff                   	(bad)  
    370e:	ff                   	(bad)  
    370f:	ff                   	(bad)  
    3710:	ff                   	(bad)  
    3711:	ff                   	(bad)  
    3712:	ff                   	(bad)  
    3713:	ff                   	(bad)  
    3714:	ff                   	(bad)  
    3715:	ff                   	(bad)  
    3716:	ff                   	(bad)  
    3717:	ff                   	(bad)  
    3718:	ff                   	(bad)  
    3719:	ff                   	(bad)  
    371a:	ff                   	(bad)  
    371b:	ff                   	(bad)  
    371c:	ff                   	(bad)  
    371d:	ff                   	(bad)  
    371e:	ff                   	(bad)  
    371f:	ff                   	(bad)  
    3720:	ff                   	(bad)  
    3721:	ff                   	(bad)  
    3722:	ff                   	(bad)  
    3723:	ff                   	(bad)  
    3724:	ff                   	(bad)  
    3725:	ff                   	(bad)  
    3726:	ff                   	(bad)  
    3727:	ff                   	(bad)  
    3728:	ff                   	(bad)  
    3729:	ff                   	(bad)  
    372a:	ff                   	(bad)  
    372b:	ff                   	(bad)  
    372c:	ff                   	(bad)  
    372d:	ff                   	(bad)  
    372e:	ff                   	(bad)  
    372f:	ff                   	(bad)  
    3730:	ff                   	(bad)  
    3731:	ff                   	(bad)  
    3732:	ff                   	(bad)  
    3733:	ff                   	(bad)  
    3734:	ff                   	(bad)  
    3735:	ff                   	(bad)  
    3736:	ff                   	(bad)  
    3737:	ff                   	(bad)  
    3738:	ff                   	(bad)  
    3739:	ff                   	(bad)  
    373a:	ff                   	(bad)  
    373b:	ff                   	(bad)  
    373c:	ff                   	(bad)  
    373d:	ff                   	(bad)  
    373e:	ff                   	(bad)  
    373f:	ff                   	(bad)  
    3740:	ff                   	(bad)  
    3741:	ff                   	(bad)  
    3742:	ff                   	(bad)  
    3743:	ff                   	(bad)  
    3744:	ff                   	(bad)  
    3745:	ff                   	(bad)  
    3746:	ff                   	(bad)  
    3747:	ff                   	(bad)  
    3748:	ff                   	(bad)  
    3749:	ff                   	(bad)  
    374a:	ff                   	(bad)  
    374b:	ff                   	(bad)  
    374c:	ff                   	(bad)  
    374d:	ff                   	(bad)  
    374e:	ff                   	(bad)  
    374f:	ff                   	(bad)  
    3750:	ff                   	(bad)  
    3751:	ff                   	(bad)  
    3752:	ff                   	(bad)  
    3753:	ff                   	(bad)  
    3754:	ff                   	(bad)  
    3755:	ff                   	(bad)  
    3756:	ff                   	(bad)  
    3757:	ff                   	(bad)  
    3758:	ff                   	(bad)  
    3759:	ff                   	(bad)  
    375a:	ff                   	(bad)  
    375b:	ff                   	(bad)  
    375c:	ff                   	(bad)  
    375d:	ff                   	(bad)  
    375e:	ff                   	(bad)  
    375f:	ff                   	(bad)  
    3760:	ff                   	(bad)  
    3761:	ff                   	(bad)  
    3762:	ff                   	(bad)  
    3763:	ff                   	(bad)  
    3764:	ff                   	(bad)  
    3765:	ff                   	(bad)  
    3766:	ff                   	(bad)  
    3767:	ff                   	(bad)  
    3768:	ff                   	(bad)  
    3769:	ff                   	(bad)  
    376a:	ff                   	(bad)  
    376b:	ff                   	(bad)  
    376c:	ff                   	(bad)  
    376d:	ff                   	(bad)  
    376e:	ff                   	(bad)  
    376f:	ff                   	(bad)  
    3770:	ff                   	(bad)  
    3771:	ff                   	(bad)  
    3772:	ff                   	(bad)  
    3773:	ff                   	(bad)  
    3774:	ff                   	(bad)  
    3775:	ff                   	(bad)  
    3776:	ff                   	(bad)  
    3777:	ff                   	(bad)  
    3778:	ff                   	(bad)  
    3779:	ff                   	(bad)  
    377a:	ff                   	(bad)  
    377b:	ff                   	(bad)  
    377c:	ff                   	(bad)  
    377d:	ff                   	(bad)  
    377e:	ff                   	(bad)  
    377f:	ff                   	(bad)  
    3780:	ff                   	(bad)  
    3781:	ff                   	(bad)  
    3782:	ff                   	(bad)  
    3783:	ff                   	(bad)  
    3784:	ff                   	(bad)  
    3785:	ff                   	(bad)  
    3786:	ff                   	(bad)  
    3787:	ff                   	(bad)  
    3788:	ff                   	(bad)  
    3789:	ff                   	(bad)  
    378a:	ff                   	(bad)  
    378b:	ff                   	(bad)  
    378c:	ff                   	(bad)  
    378d:	ff                   	(bad)  
    378e:	ff                   	(bad)  
    378f:	ff                   	(bad)  
    3790:	ff                   	(bad)  
    3791:	ff                   	(bad)  
    3792:	ff                   	(bad)  
    3793:	ff                   	(bad)  
    3794:	ff                   	(bad)  
    3795:	ff                   	(bad)  
    3796:	ff                   	(bad)  
    3797:	ff                   	(bad)  
    3798:	ff                   	(bad)  
    3799:	ff                   	(bad)  
    379a:	ff                   	(bad)  
    379b:	ff                   	(bad)  
    379c:	ff                   	(bad)  
    379d:	ff                   	(bad)  
    379e:	ff                   	(bad)  
    379f:	ff                   	(bad)  
    37a0:	ff                   	(bad)  
    37a1:	ff                   	(bad)  
    37a2:	ff                   	(bad)  
    37a3:	ff                   	(bad)  
    37a4:	ff                   	(bad)  
    37a5:	ff                   	(bad)  
    37a6:	ff                   	(bad)  
    37a7:	ff                   	(bad)  
    37a8:	ff                   	(bad)  
    37a9:	ff                   	(bad)  
    37aa:	ff                   	(bad)  
    37ab:	ff                   	(bad)  
    37ac:	ff                   	(bad)  
    37ad:	ff                   	(bad)  
    37ae:	ff                   	(bad)  
    37af:	ff                   	(bad)  
    37b0:	ff                   	(bad)  
    37b1:	ff                   	(bad)  
    37b2:	ff                   	(bad)  
    37b3:	ff                   	(bad)  
    37b4:	ff                   	(bad)  
    37b5:	ff                   	(bad)  
    37b6:	ff                   	(bad)  
    37b7:	ff                   	(bad)  
    37b8:	ff                   	(bad)  
    37b9:	ff                   	(bad)  
    37ba:	ff                   	(bad)  
    37bb:	ff                   	(bad)  
    37bc:	ff                   	(bad)  
    37bd:	ff                   	(bad)  
    37be:	ff                   	(bad)  
    37bf:	ff                   	(bad)  
    37c0:	ff                   	(bad)  
    37c1:	ff                   	(bad)  
    37c2:	ff                   	(bad)  
    37c3:	ff                   	(bad)  
    37c4:	ff                   	(bad)  
    37c5:	ff                   	(bad)  
    37c6:	ff                   	(bad)  
    37c7:	ff                   	(bad)  
    37c8:	ff                   	(bad)  
    37c9:	ff                   	(bad)  
    37ca:	ff                   	(bad)  
    37cb:	ff                   	(bad)  
    37cc:	ff                   	(bad)  
    37cd:	ff                   	(bad)  
    37ce:	ff                   	(bad)  
    37cf:	ff                   	(bad)  
    37d0:	ff                   	(bad)  
    37d1:	ff                   	(bad)  
    37d2:	ff                   	(bad)  
    37d3:	ff                   	(bad)  
    37d4:	ff                   	(bad)  
    37d5:	ff                   	(bad)  
    37d6:	ff                   	(bad)  
    37d7:	ff                   	(bad)  
    37d8:	ff                   	(bad)  
    37d9:	ff                   	(bad)  
    37da:	ff                   	(bad)  
    37db:	ff                   	(bad)  
    37dc:	ff                   	(bad)  
    37dd:	ff                   	(bad)  
    37de:	ff                   	(bad)  
    37df:	ff                   	(bad)  
    37e0:	ff                   	(bad)  
    37e1:	ff                   	(bad)  
    37e2:	ff                   	(bad)  
    37e3:	ff                   	(bad)  
    37e4:	ff                   	(bad)  
    37e5:	ff                   	(bad)  
    37e6:	ff                   	(bad)  
    37e7:	ff                   	(bad)  
    37e8:	ff                   	(bad)  
    37e9:	ff                   	(bad)  
    37ea:	ff                   	(bad)  
    37eb:	ff                   	(bad)  
    37ec:	ff                   	(bad)  
    37ed:	ff                   	(bad)  
    37ee:	ff                   	(bad)  
    37ef:	ff                   	(bad)  
    37f0:	ff                   	(bad)  
    37f1:	ff                   	(bad)  
    37f2:	ff                   	(bad)  
    37f3:	ff                   	(bad)  
    37f4:	ff                   	(bad)  
    37f5:	ff                   	(bad)  
    37f6:	ff                   	(bad)  
    37f7:	ff                   	(bad)  
    37f8:	ff                   	(bad)  
    37f9:	ff                   	(bad)  
    37fa:	ff                   	(bad)  
    37fb:	ff                   	(bad)  
    37fc:	ff                   	(bad)  
    37fd:	ff                   	(bad)  
    37fe:	ff                   	(bad)  
    37ff:	ff                   	(bad)  
    3800:	ff                   	(bad)  
    3801:	ff                   	(bad)  
    3802:	ff                   	(bad)  
    3803:	ff                   	(bad)  
    3804:	ff                   	(bad)  
    3805:	ff                   	(bad)  
    3806:	ff                   	(bad)  
    3807:	ff                   	(bad)  
    3808:	ff                   	(bad)  
    3809:	ff                   	(bad)  
    380a:	ff                   	(bad)  
    380b:	ff                   	(bad)  
    380c:	ff                   	(bad)  
    380d:	ff                   	(bad)  
    380e:	ff                   	(bad)  
    380f:	ff                   	(bad)  
    3810:	ff                   	(bad)  
    3811:	ff                   	(bad)  
    3812:	ff                   	(bad)  
    3813:	ff                   	(bad)  
    3814:	ff                   	(bad)  
    3815:	ff                   	(bad)  
    3816:	ff                   	(bad)  
    3817:	ff                   	(bad)  
    3818:	ff                   	(bad)  
    3819:	ff                   	(bad)  
    381a:	ff                   	(bad)  
    381b:	ff                   	(bad)  
    381c:	ff                   	(bad)  
    381d:	ff                   	(bad)  
    381e:	ff                   	(bad)  
    381f:	ff                   	(bad)  
    3820:	ff                   	(bad)  
    3821:	ff                   	(bad)  
    3822:	ff                   	(bad)  
    3823:	ff                   	(bad)  
    3824:	ff                   	(bad)  
    3825:	ff                   	(bad)  
    3826:	ff                   	(bad)  
    3827:	ff                   	(bad)  
    3828:	ff                   	(bad)  
    3829:	ff                   	(bad)  
    382a:	ff                   	(bad)  
    382b:	ff                   	(bad)  
    382c:	ff                   	(bad)  
    382d:	ff                   	(bad)  
    382e:	ff                   	(bad)  
    382f:	ff                   	(bad)  
    3830:	ff                   	(bad)  
    3831:	ff                   	(bad)  
    3832:	ff                   	(bad)  
    3833:	ff                   	(bad)  
    3834:	ff                   	(bad)  
    3835:	ff                   	(bad)  
    3836:	ff                   	(bad)  
    3837:	ff                   	(bad)  
    3838:	ff                   	(bad)  
    3839:	ff                   	(bad)  
    383a:	ff                   	(bad)  
    383b:	ff                   	(bad)  
    383c:	ff                   	(bad)  
    383d:	ff                   	(bad)  
    383e:	ff                   	(bad)  
    383f:	ff                   	(bad)  
    3840:	ff                   	(bad)  
    3841:	ff                   	(bad)  
    3842:	ff                   	(bad)  
    3843:	ff                   	(bad)  
    3844:	ff                   	(bad)  
    3845:	ff                   	(bad)  
    3846:	ff                   	(bad)  
    3847:	ff                   	(bad)  
    3848:	ff                   	(bad)  
    3849:	ff                   	(bad)  
    384a:	ff                   	(bad)  
    384b:	ff                   	(bad)  
    384c:	ff                   	(bad)  
    384d:	ff                   	(bad)  
    384e:	ff                   	(bad)  
    384f:	ff                   	(bad)  
    3850:	ff                   	(bad)  
    3851:	ff                   	(bad)  
    3852:	ff                   	(bad)  
    3853:	ff                   	(bad)  
    3854:	ff                   	(bad)  
    3855:	ff                   	(bad)  
    3856:	ff                   	(bad)  
    3857:	ff                   	(bad)  
    3858:	ff                   	(bad)  
    3859:	ff                   	(bad)  
    385a:	ff                   	(bad)  
    385b:	ff                   	(bad)  
    385c:	ff                   	(bad)  
    385d:	ff                   	(bad)  
    385e:	ff                   	(bad)  
    385f:	ff                   	(bad)  
    3860:	ff                   	(bad)  
    3861:	ff                   	(bad)  
    3862:	ff                   	(bad)  
    3863:	ff                   	(bad)  
    3864:	ff                   	(bad)  
    3865:	ff                   	(bad)  
    3866:	ff                   	(bad)  
    3867:	ff                   	(bad)  
    3868:	ff                   	(bad)  
    3869:	ff                   	(bad)  
    386a:	ff                   	(bad)  
    386b:	ff                   	(bad)  
    386c:	ff                   	(bad)  
    386d:	ff                   	(bad)  
    386e:	ff                   	(bad)  
    386f:	ff                   	(bad)  
    3870:	ff                   	(bad)  
    3871:	ff                   	(bad)  
    3872:	ff                   	(bad)  
    3873:	ff                   	(bad)  
    3874:	ff                   	(bad)  
    3875:	ff                   	(bad)  
    3876:	ff                   	(bad)  
    3877:	ff                   	(bad)  
    3878:	ff                   	(bad)  
    3879:	ff                   	(bad)  
    387a:	ff                   	(bad)  
    387b:	ff                   	(bad)  
    387c:	ff                   	(bad)  
    387d:	ff                   	(bad)  
    387e:	ff                   	(bad)  
    387f:	ff                   	(bad)  
    3880:	ff                   	(bad)  
    3881:	ff                   	(bad)  
    3882:	ff                   	(bad)  
    3883:	ff                   	(bad)  
    3884:	ff                   	(bad)  
    3885:	ff                   	(bad)  
    3886:	ff                   	(bad)  
    3887:	ff                   	(bad)  
    3888:	ff                   	(bad)  
    3889:	ff                   	(bad)  
    388a:	ff                   	(bad)  
    388b:	ff                   	(bad)  
    388c:	ff                   	(bad)  
    388d:	ff                   	(bad)  
    388e:	ff                   	(bad)  
    388f:	ff                   	(bad)  
    3890:	ff                   	(bad)  
    3891:	ff                   	(bad)  
    3892:	ff                   	(bad)  
    3893:	ff                   	(bad)  
    3894:	ff                   	(bad)  
    3895:	ff                   	(bad)  
    3896:	ff                   	(bad)  
    3897:	ff                   	(bad)  
    3898:	ff                   	(bad)  
    3899:	ff                   	(bad)  
    389a:	ff                   	(bad)  
    389b:	ff                   	(bad)  
    389c:	ff                   	(bad)  
    389d:	ff                   	(bad)  
    389e:	ff                   	(bad)  
    389f:	ff                   	(bad)  
    38a0:	ff                   	(bad)  
    38a1:	ff                   	(bad)  
    38a2:	ff                   	(bad)  
    38a3:	ff                   	(bad)  
    38a4:	ff                   	(bad)  
    38a5:	ff                   	(bad)  
    38a6:	ff                   	(bad)  
    38a7:	ff                   	(bad)  
    38a8:	ff                   	(bad)  
    38a9:	ff                   	(bad)  
    38aa:	ff                   	(bad)  
    38ab:	ff                   	(bad)  
    38ac:	ff                   	(bad)  
    38ad:	ff                   	(bad)  
    38ae:	ff                   	(bad)  
    38af:	ff                   	(bad)  
    38b0:	ff                   	(bad)  
    38b1:	ff                   	(bad)  
    38b2:	ff                   	(bad)  
    38b3:	ff                   	(bad)  
    38b4:	ff                   	(bad)  
    38b5:	ff                   	(bad)  
    38b6:	ff                   	(bad)  
    38b7:	ff                   	(bad)  
    38b8:	ff                   	(bad)  
    38b9:	ff                   	(bad)  
    38ba:	ff                   	(bad)  
    38bb:	ff                   	(bad)  
    38bc:	ff                   	(bad)  
    38bd:	ff                   	(bad)  
    38be:	ff                   	(bad)  
    38bf:	ff                   	(bad)  
    38c0:	ff                   	(bad)  
    38c1:	ff                   	(bad)  
    38c2:	ff                   	(bad)  
    38c3:	ff                   	(bad)  
    38c4:	ff                   	(bad)  
    38c5:	ff                   	(bad)  
    38c6:	ff                   	(bad)  
    38c7:	ff                   	(bad)  
    38c8:	ff                   	(bad)  
    38c9:	ff                   	(bad)  
    38ca:	ff                   	(bad)  
    38cb:	ff                   	(bad)  
    38cc:	ff                   	(bad)  
    38cd:	ff                   	(bad)  
    38ce:	ff                   	(bad)  
    38cf:	ff                   	(bad)  
    38d0:	ff                   	(bad)  
    38d1:	ff                   	(bad)  
    38d2:	ff                   	(bad)  
    38d3:	ff                   	(bad)  
    38d4:	ff                   	(bad)  
    38d5:	ff                   	(bad)  
    38d6:	ff                   	(bad)  
    38d7:	ff                   	(bad)  
    38d8:	ff                   	(bad)  
    38d9:	ff                   	(bad)  
    38da:	ff                   	(bad)  
    38db:	ff                   	(bad)  
    38dc:	ff                   	(bad)  
    38dd:	ff                   	(bad)  
    38de:	ff                   	(bad)  
    38df:	ff                   	(bad)  
    38e0:	ff                   	(bad)  
    38e1:	ff                   	(bad)  
    38e2:	ff                   	(bad)  
    38e3:	ff                   	(bad)  
    38e4:	ff                   	(bad)  
    38e5:	ff                   	(bad)  
    38e6:	ff                   	(bad)  
    38e7:	ff                   	(bad)  
    38e8:	ff                   	(bad)  
    38e9:	ff                   	(bad)  
    38ea:	ff                   	(bad)  
    38eb:	ff                   	(bad)  
    38ec:	ff                   	(bad)  
    38ed:	ff                   	(bad)  
    38ee:	ff                   	(bad)  
    38ef:	ff                   	(bad)  
    38f0:	ff                   	(bad)  
    38f1:	ff                   	(bad)  
    38f2:	ff                   	(bad)  
    38f3:	ff                   	(bad)  
    38f4:	ff                   	(bad)  
    38f5:	ff                   	(bad)  
    38f6:	ff                   	(bad)  
    38f7:	ff                   	(bad)  
    38f8:	ff                   	(bad)  
    38f9:	ff                   	(bad)  
    38fa:	ff                   	(bad)  
    38fb:	ff                   	(bad)  
    38fc:	ff                   	(bad)  
    38fd:	ff                   	(bad)  
    38fe:	ff                   	(bad)  
    38ff:	ff                   	(bad)  
    3900:	ff                   	(bad)  
    3901:	ff                   	(bad)  
    3902:	ff                   	(bad)  
    3903:	ff                   	(bad)  
    3904:	ff                   	(bad)  
    3905:	ff                   	(bad)  
    3906:	ff                   	(bad)  
    3907:	ff                   	(bad)  
    3908:	ff                   	(bad)  
    3909:	ff                   	(bad)  
    390a:	ff                   	(bad)  
    390b:	ff                   	(bad)  
    390c:	ff                   	(bad)  
    390d:	ff                   	(bad)  
    390e:	ff                   	(bad)  
    390f:	ff                   	(bad)  
    3910:	ff                   	(bad)  
    3911:	ff                   	(bad)  
    3912:	ff                   	(bad)  
    3913:	ff                   	(bad)  
    3914:	ff                   	(bad)  
    3915:	ff                   	(bad)  
    3916:	ff                   	(bad)  
    3917:	ff                   	(bad)  
    3918:	ff                   	(bad)  
    3919:	ff                   	(bad)  
    391a:	ff                   	(bad)  
    391b:	ff                   	(bad)  
    391c:	ff                   	(bad)  
    391d:	ff                   	(bad)  
    391e:	ff                   	(bad)  
    391f:	ff                   	(bad)  
    3920:	ff                   	(bad)  
    3921:	ff                   	(bad)  
    3922:	ff                   	(bad)  
    3923:	ff                   	(bad)  
    3924:	ff                   	(bad)  
    3925:	ff                   	(bad)  
    3926:	ff                   	(bad)  
    3927:	ff                   	(bad)  
    3928:	ff                   	(bad)  
    3929:	ff                   	(bad)  
    392a:	ff                   	(bad)  
    392b:	ff                   	(bad)  
    392c:	ff                   	(bad)  
    392d:	ff                   	(bad)  
    392e:	ff                   	(bad)  
    392f:	ff                   	(bad)  
    3930:	ff                   	(bad)  
    3931:	ff                   	(bad)  
    3932:	ff                   	(bad)  
    3933:	ff                   	(bad)  
    3934:	ff                   	(bad)  
    3935:	ff                   	(bad)  
    3936:	ff                   	(bad)  
    3937:	ff                   	(bad)  
    3938:	ff                   	(bad)  
    3939:	ff                   	(bad)  
    393a:	ff                   	(bad)  
    393b:	ff                   	(bad)  
    393c:	ff                   	(bad)  
    393d:	ff                   	(bad)  
    393e:	ff                   	(bad)  
    393f:	ff                   	(bad)  
    3940:	ff                   	(bad)  
    3941:	ff                   	(bad)  
    3942:	ff                   	(bad)  
    3943:	ff                   	(bad)  
    3944:	ff                   	(bad)  
    3945:	ff                   	(bad)  
    3946:	ff                   	(bad)  
    3947:	ff                   	(bad)  
    3948:	ff                   	(bad)  
    3949:	ff                   	(bad)  
    394a:	ff                   	(bad)  
    394b:	ff                   	(bad)  
    394c:	ff                   	(bad)  
    394d:	ff                   	(bad)  
    394e:	ff                   	(bad)  
    394f:	ff                   	(bad)  
    3950:	ff                   	(bad)  
    3951:	ff                   	(bad)  
    3952:	ff                   	(bad)  
    3953:	ff                   	(bad)  
    3954:	ff                   	(bad)  
    3955:	ff                   	(bad)  
    3956:	ff                   	(bad)  
    3957:	ff                   	(bad)  
    3958:	ff                   	(bad)  
    3959:	ff                   	(bad)  
    395a:	ff                   	(bad)  
    395b:	ff                   	(bad)  
    395c:	ff                   	(bad)  
    395d:	ff                   	(bad)  
    395e:	ff                   	(bad)  
    395f:	ff                   	(bad)  
    3960:	ff                   	(bad)  
    3961:	ff                   	(bad)  
    3962:	ff                   	(bad)  
    3963:	ff                   	(bad)  
    3964:	ff                   	(bad)  
    3965:	ff                   	(bad)  
    3966:	ff                   	(bad)  
    3967:	ff                   	(bad)  
    3968:	ff                   	(bad)  
    3969:	ff                   	(bad)  
    396a:	ff                   	(bad)  
    396b:	ff                   	(bad)  
    396c:	ff                   	(bad)  
    396d:	ff                   	(bad)  
    396e:	ff                   	(bad)  
    396f:	ff                   	(bad)  
    3970:	ff                   	(bad)  
    3971:	ff                   	(bad)  
    3972:	ff                   	(bad)  
    3973:	ff                   	(bad)  
    3974:	ff                   	(bad)  
    3975:	ff                   	(bad)  
    3976:	ff                   	(bad)  
    3977:	ff                   	(bad)  
    3978:	ff                   	(bad)  
    3979:	ff                   	(bad)  
    397a:	ff                   	(bad)  
    397b:	ff                   	(bad)  
    397c:	ff                   	(bad)  
    397d:	ff                   	(bad)  
    397e:	ff                   	(bad)  
    397f:	ff                   	(bad)  
    3980:	ff                   	(bad)  
    3981:	ff                   	(bad)  
    3982:	ff                   	(bad)  
    3983:	ff                   	(bad)  
    3984:	ff                   	(bad)  
    3985:	ff                   	(bad)  
    3986:	ff                   	(bad)  
    3987:	ff                   	(bad)  
    3988:	ff                   	(bad)  
    3989:	ff                   	(bad)  
    398a:	ff                   	(bad)  
    398b:	ff                   	(bad)  
    398c:	ff                   	(bad)  
    398d:	ff                   	(bad)  
    398e:	ff                   	(bad)  
    398f:	ff                   	(bad)  
    3990:	ff                   	(bad)  
    3991:	ff                   	(bad)  
    3992:	ff                   	(bad)  
    3993:	ff                   	(bad)  
    3994:	ff                   	(bad)  
    3995:	ff                   	(bad)  
    3996:	ff                   	(bad)  
    3997:	ff                   	(bad)  
    3998:	ff                   	(bad)  
    3999:	ff                   	(bad)  
    399a:	ff                   	(bad)  
    399b:	ff                   	(bad)  
    399c:	ff                   	(bad)  
    399d:	ff                   	(bad)  
    399e:	ff                   	(bad)  
    399f:	ff                   	(bad)  
    39a0:	ff                   	(bad)  
    39a1:	ff                   	(bad)  
    39a2:	ff                   	(bad)  
    39a3:	ff                   	(bad)  
    39a4:	ff                   	(bad)  
    39a5:	ff                   	(bad)  
    39a6:	ff                   	(bad)  
    39a7:	ff                   	(bad)  
    39a8:	ff                   	(bad)  
    39a9:	ff                   	(bad)  
    39aa:	ff                   	(bad)  
    39ab:	ff                   	(bad)  
    39ac:	ff                   	(bad)  
    39ad:	ff                   	(bad)  
    39ae:	ff                   	(bad)  
    39af:	ff                   	(bad)  
    39b0:	ff                   	(bad)  
    39b1:	ff                   	(bad)  
    39b2:	ff                   	(bad)  
    39b3:	ff                   	(bad)  
    39b4:	ff                   	(bad)  
    39b5:	ff                   	(bad)  
    39b6:	ff                   	(bad)  
    39b7:	ff                   	(bad)  
    39b8:	ff                   	(bad)  
    39b9:	ff                   	(bad)  
    39ba:	ff                   	(bad)  
    39bb:	ff                   	(bad)  
    39bc:	ff                   	(bad)  
    39bd:	ff                   	(bad)  
    39be:	ff                   	(bad)  
    39bf:	ff                   	(bad)  
    39c0:	ff                   	(bad)  
    39c1:	ff                   	(bad)  
    39c2:	ff                   	(bad)  
    39c3:	ff                   	(bad)  
    39c4:	ff                   	(bad)  
    39c5:	ff                   	(bad)  
    39c6:	ff                   	(bad)  
    39c7:	ff                   	(bad)  
    39c8:	ff                   	(bad)  
    39c9:	ff                   	(bad)  
    39ca:	ff                   	(bad)  
    39cb:	ff                   	(bad)  
    39cc:	ff                   	(bad)  
    39cd:	ff                   	(bad)  
    39ce:	ff                   	(bad)  
    39cf:	ff                   	(bad)  
    39d0:	ff                   	(bad)  
    39d1:	ff                   	(bad)  
    39d2:	ff                   	(bad)  
    39d3:	ff                   	(bad)  
    39d4:	ff                   	(bad)  
    39d5:	ff                   	(bad)  
    39d6:	ff                   	(bad)  
    39d7:	ff                   	(bad)  
    39d8:	ff                   	(bad)  
    39d9:	ff                   	(bad)  
    39da:	ff                   	(bad)  
    39db:	ff                   	(bad)  
    39dc:	ff                   	(bad)  
    39dd:	ff                   	(bad)  
    39de:	ff                   	(bad)  
    39df:	ff                   	(bad)  
    39e0:	ff                   	(bad)  
    39e1:	ff                   	(bad)  
    39e2:	ff                   	(bad)  
    39e3:	ff                   	(bad)  
    39e4:	ff                   	(bad)  
    39e5:	ff                   	(bad)  
    39e6:	ff                   	(bad)  
    39e7:	ff                   	(bad)  
    39e8:	ff                   	(bad)  
    39e9:	ff                   	(bad)  
    39ea:	ff                   	(bad)  
    39eb:	ff                   	(bad)  
    39ec:	ff                   	(bad)  
    39ed:	ff                   	(bad)  
    39ee:	ff                   	(bad)  
    39ef:	ff                   	(bad)  
    39f0:	ff                   	(bad)  
    39f1:	ff                   	(bad)  
    39f2:	ff                   	(bad)  
    39f3:	ff                   	(bad)  
    39f4:	ff                   	(bad)  
    39f5:	ff                   	(bad)  
    39f6:	ff                   	(bad)  
    39f7:	ff                   	(bad)  
    39f8:	ff                   	(bad)  
    39f9:	ff                   	(bad)  
    39fa:	ff                   	(bad)  
    39fb:	ff                   	(bad)  
    39fc:	ff                   	(bad)  
    39fd:	ff                   	(bad)  
    39fe:	ff                   	(bad)  
    39ff:	ff                   	(bad)  
    3a00:	ff                   	(bad)  
    3a01:	ff                   	(bad)  
    3a02:	ff                   	(bad)  
    3a03:	ff                   	(bad)  
    3a04:	ff                   	(bad)  
    3a05:	ff                   	(bad)  
    3a06:	ff                   	(bad)  
    3a07:	ff                   	(bad)  
    3a08:	ff                   	(bad)  
    3a09:	ff                   	(bad)  
    3a0a:	ff                   	(bad)  
    3a0b:	ff                   	(bad)  
    3a0c:	ff                   	(bad)  
    3a0d:	ff                   	(bad)  
    3a0e:	ff                   	(bad)  
    3a0f:	ff                   	(bad)  
    3a10:	ff                   	(bad)  
    3a11:	ff                   	(bad)  
    3a12:	ff                   	(bad)  
    3a13:	ff                   	(bad)  
    3a14:	ff                   	(bad)  
    3a15:	ff                   	(bad)  
    3a16:	ff                   	(bad)  
    3a17:	ff                   	(bad)  
    3a18:	ff                   	(bad)  
    3a19:	ff                   	(bad)  
    3a1a:	ff                   	(bad)  
    3a1b:	ff                   	(bad)  
    3a1c:	ff                   	(bad)  
    3a1d:	ff                   	(bad)  
    3a1e:	ff                   	(bad)  
    3a1f:	ff                   	(bad)  
    3a20:	ff                   	(bad)  
    3a21:	ff                   	(bad)  
    3a22:	ff                   	(bad)  
    3a23:	ff                   	(bad)  
    3a24:	ff                   	(bad)  
    3a25:	ff                   	(bad)  
    3a26:	ff                   	(bad)  
    3a27:	ff                   	(bad)  
    3a28:	ff                   	(bad)  
    3a29:	ff                   	(bad)  
    3a2a:	ff                   	(bad)  
    3a2b:	ff                   	(bad)  
    3a2c:	ff                   	(bad)  
    3a2d:	ff                   	(bad)  
    3a2e:	ff                   	(bad)  
    3a2f:	ff                   	(bad)  
    3a30:	ff                   	(bad)  
    3a31:	ff                   	(bad)  
    3a32:	ff                   	(bad)  
    3a33:	ff                   	(bad)  
    3a34:	ff                   	(bad)  
    3a35:	ff                   	(bad)  
    3a36:	ff                   	(bad)  
    3a37:	ff                   	(bad)  
    3a38:	ff                   	(bad)  
    3a39:	ff                   	(bad)  
    3a3a:	ff                   	(bad)  
    3a3b:	ff                   	(bad)  
    3a3c:	ff                   	(bad)  
    3a3d:	ff                   	(bad)  
    3a3e:	ff                   	(bad)  
    3a3f:	ff                   	(bad)  
    3a40:	ff                   	(bad)  
    3a41:	ff                   	(bad)  
    3a42:	ff                   	(bad)  
    3a43:	ff                   	(bad)  
    3a44:	ff                   	(bad)  
    3a45:	ff                   	(bad)  
    3a46:	ff                   	(bad)  
    3a47:	ff                   	(bad)  
    3a48:	ff                   	(bad)  
    3a49:	ff                   	(bad)  
    3a4a:	ff                   	(bad)  
    3a4b:	ff                   	(bad)  
    3a4c:	ff                   	(bad)  
    3a4d:	ff                   	(bad)  
    3a4e:	ff                   	(bad)  
    3a4f:	ff                   	(bad)  
    3a50:	ff                   	(bad)  
    3a51:	ff                   	(bad)  
    3a52:	ff                   	(bad)  
    3a53:	ff                   	(bad)  
    3a54:	ff                   	(bad)  
    3a55:	ff                   	(bad)  
    3a56:	ff                   	(bad)  
    3a57:	ff                   	(bad)  
    3a58:	ff                   	(bad)  
    3a59:	ff                   	(bad)  
    3a5a:	ff                   	(bad)  
    3a5b:	ff                   	(bad)  
    3a5c:	ff                   	(bad)  
    3a5d:	ff                   	(bad)  
    3a5e:	ff                   	(bad)  
    3a5f:	ff                   	(bad)  
    3a60:	ff                   	(bad)  
    3a61:	ff                   	(bad)  
    3a62:	ff                   	(bad)  
    3a63:	ff                   	(bad)  
    3a64:	ff                   	(bad)  
    3a65:	ff                   	(bad)  
    3a66:	ff                   	(bad)  
    3a67:	ff                   	(bad)  
    3a68:	ff                   	(bad)  
    3a69:	ff                   	(bad)  
    3a6a:	ff                   	(bad)  
    3a6b:	ff                   	(bad)  
    3a6c:	ff                   	(bad)  
    3a6d:	ff                   	(bad)  
    3a6e:	ff                   	(bad)  
    3a6f:	ff                   	(bad)  
    3a70:	ff                   	(bad)  
    3a71:	ff                   	(bad)  
    3a72:	ff                   	(bad)  
    3a73:	ff                   	(bad)  
    3a74:	ff                   	(bad)  
    3a75:	ff                   	(bad)  
    3a76:	ff                   	(bad)  
    3a77:	ff                   	(bad)  
    3a78:	ff                   	(bad)  
    3a79:	ff                   	(bad)  
    3a7a:	ff                   	(bad)  
    3a7b:	ff                   	(bad)  
    3a7c:	ff                   	(bad)  
    3a7d:	ff                   	(bad)  
    3a7e:	ff                   	(bad)  
    3a7f:	ff                   	(bad)  
    3a80:	ff                   	(bad)  
    3a81:	ff                   	(bad)  
    3a82:	ff                   	(bad)  
    3a83:	ff                   	(bad)  
    3a84:	ff                   	(bad)  
    3a85:	ff                   	(bad)  
    3a86:	ff                   	(bad)  
    3a87:	ff                   	(bad)  
    3a88:	ff                   	(bad)  
    3a89:	ff                   	(bad)  
    3a8a:	ff                   	(bad)  
    3a8b:	ff                   	(bad)  
    3a8c:	ff                   	(bad)  
    3a8d:	ff                   	(bad)  
    3a8e:	ff                   	(bad)  
    3a8f:	ff                   	(bad)  
    3a90:	ff                   	(bad)  
    3a91:	ff                   	(bad)  
    3a92:	ff                   	(bad)  
    3a93:	ff                   	(bad)  
    3a94:	ff                   	(bad)  
    3a95:	ff                   	(bad)  
    3a96:	ff                   	(bad)  
    3a97:	ff                   	(bad)  
    3a98:	ff                   	(bad)  
    3a99:	ff                   	(bad)  
    3a9a:	ff                   	(bad)  
    3a9b:	ff                   	(bad)  
    3a9c:	ff                   	(bad)  
    3a9d:	ff                   	(bad)  
    3a9e:	ff                   	(bad)  
    3a9f:	ff                   	(bad)  
    3aa0:	ff                   	(bad)  
    3aa1:	ff                   	(bad)  
    3aa2:	ff                   	(bad)  
    3aa3:	ff                   	(bad)  
    3aa4:	ff                   	(bad)  
    3aa5:	ff                   	(bad)  
    3aa6:	ff                   	(bad)  
    3aa7:	ff                   	(bad)  
    3aa8:	ff                   	(bad)  
    3aa9:	ff                   	(bad)  
    3aaa:	ff                   	(bad)  
    3aab:	ff                   	(bad)  
    3aac:	ff                   	(bad)  
    3aad:	ff                   	(bad)  
    3aae:	ff                   	(bad)  
    3aaf:	ff                   	(bad)  
    3ab0:	ff                   	(bad)  
    3ab1:	ff                   	(bad)  
    3ab2:	ff                   	(bad)  
    3ab3:	ff                   	(bad)  
    3ab4:	ff                   	(bad)  
    3ab5:	ff                   	(bad)  
    3ab6:	ff                   	(bad)  
    3ab7:	ff                   	(bad)  
    3ab8:	ff                   	(bad)  
    3ab9:	ff                   	(bad)  
    3aba:	ff                   	(bad)  
    3abb:	ff                   	(bad)  
    3abc:	ff                   	(bad)  
    3abd:	ff                   	(bad)  
    3abe:	ff                   	(bad)  
    3abf:	ff                   	(bad)  
    3ac0:	ff                   	(bad)  
    3ac1:	ff                   	(bad)  
    3ac2:	ff                   	(bad)  
    3ac3:	ff                   	(bad)  
    3ac4:	ff                   	(bad)  
    3ac5:	ff                   	(bad)  
    3ac6:	ff                   	(bad)  
    3ac7:	ff                   	(bad)  
    3ac8:	ff                   	(bad)  
    3ac9:	ff                   	(bad)  
    3aca:	ff                   	(bad)  
    3acb:	ff                   	(bad)  
    3acc:	ff                   	(bad)  
    3acd:	ff                   	(bad)  
    3ace:	ff                   	(bad)  
    3acf:	ff                   	(bad)  
    3ad0:	ff                   	(bad)  
    3ad1:	ff                   	(bad)  
    3ad2:	ff                   	(bad)  
    3ad3:	ff                   	(bad)  
    3ad4:	ff                   	(bad)  
    3ad5:	ff                   	(bad)  
    3ad6:	ff                   	(bad)  
    3ad7:	ff                   	(bad)  
    3ad8:	ff                   	(bad)  
    3ad9:	ff                   	(bad)  
    3ada:	ff                   	(bad)  
    3adb:	ff                   	(bad)  
    3adc:	ff                   	(bad)  
    3add:	ff                   	(bad)  
    3ade:	ff                   	(bad)  
    3adf:	ff                   	(bad)  
    3ae0:	ff                   	(bad)  
    3ae1:	ff                   	(bad)  
    3ae2:	ff                   	(bad)  
    3ae3:	ff                   	(bad)  
    3ae4:	ff                   	(bad)  
    3ae5:	ff                   	(bad)  
    3ae6:	ff                   	(bad)  
    3ae7:	ff                   	(bad)  
    3ae8:	ff                   	(bad)  
    3ae9:	ff                   	(bad)  
    3aea:	ff                   	(bad)  
    3aeb:	ff                   	(bad)  
    3aec:	ff                   	(bad)  
    3aed:	ff                   	(bad)  
    3aee:	ff                   	(bad)  
    3aef:	ff                   	(bad)  
    3af0:	ff                   	(bad)  
    3af1:	ff                   	(bad)  
    3af2:	ff                   	(bad)  
    3af3:	ff                   	(bad)  
    3af4:	ff                   	(bad)  
    3af5:	ff                   	(bad)  
    3af6:	ff                   	(bad)  
    3af7:	ff                   	(bad)  
    3af8:	ff                   	(bad)  
    3af9:	ff                   	(bad)  
    3afa:	ff                   	(bad)  
    3afb:	ff                   	(bad)  
    3afc:	ff                   	(bad)  
    3afd:	ff                   	(bad)  
    3afe:	ff                   	(bad)  
    3aff:	ff                   	(bad)  
    3b00:	ff                   	(bad)  
    3b01:	ff                   	(bad)  
    3b02:	ff                   	(bad)  
    3b03:	ff                   	(bad)  
    3b04:	ff                   	(bad)  
    3b05:	ff                   	(bad)  
    3b06:	ff                   	(bad)  
    3b07:	ff                   	(bad)  
    3b08:	ff                   	(bad)  
    3b09:	ff                   	(bad)  
    3b0a:	ff                   	(bad)  
    3b0b:	ff                   	(bad)  
    3b0c:	ff                   	(bad)  
    3b0d:	ff                   	(bad)  
    3b0e:	ff                   	(bad)  
    3b0f:	ff                   	(bad)  
    3b10:	ff                   	(bad)  
    3b11:	ff                   	(bad)  
    3b12:	ff                   	(bad)  
    3b13:	ff                   	(bad)  
    3b14:	ff                   	(bad)  
    3b15:	ff                   	(bad)  
    3b16:	ff                   	(bad)  
    3b17:	ff                   	(bad)  
    3b18:	ff                   	(bad)  
    3b19:	ff                   	(bad)  
    3b1a:	ff                   	(bad)  
    3b1b:	ff                   	(bad)  
    3b1c:	ff                   	(bad)  
    3b1d:	ff                   	(bad)  
    3b1e:	ff                   	(bad)  
    3b1f:	ff                   	(bad)  
    3b20:	ff                   	(bad)  
    3b21:	ff                   	(bad)  
    3b22:	ff                   	(bad)  
    3b23:	ff                   	(bad)  
    3b24:	ff                   	(bad)  
    3b25:	ff                   	(bad)  
    3b26:	ff                   	(bad)  
    3b27:	ff                   	(bad)  
    3b28:	ff                   	(bad)  
    3b29:	ff                   	(bad)  
    3b2a:	ff                   	(bad)  
    3b2b:	ff                   	(bad)  
    3b2c:	ff                   	(bad)  
    3b2d:	ff                   	(bad)  
    3b2e:	ff                   	(bad)  
    3b2f:	ff                   	(bad)  
    3b30:	ff                   	(bad)  
    3b31:	ff                   	(bad)  
    3b32:	ff                   	(bad)  
    3b33:	ff                   	(bad)  
    3b34:	ff                   	(bad)  
    3b35:	ff                   	(bad)  
    3b36:	ff                   	(bad)  
    3b37:	ff                   	(bad)  
    3b38:	ff                   	(bad)  
    3b39:	ff                   	(bad)  
    3b3a:	ff                   	(bad)  
    3b3b:	ff                   	(bad)  
    3b3c:	ff                   	(bad)  
    3b3d:	ff                   	(bad)  
    3b3e:	ff                   	(bad)  
    3b3f:	ff                   	(bad)  
    3b40:	ff                   	(bad)  
    3b41:	ff                   	(bad)  
    3b42:	ff                   	(bad)  
    3b43:	ff                   	(bad)  
    3b44:	ff                   	(bad)  
    3b45:	ff                   	(bad)  
    3b46:	ff                   	(bad)  
    3b47:	ff                   	(bad)  
    3b48:	ff                   	(bad)  
    3b49:	ff                   	(bad)  
    3b4a:	ff                   	(bad)  
    3b4b:	ff                   	(bad)  
    3b4c:	ff                   	(bad)  
    3b4d:	ff                   	(bad)  
    3b4e:	ff                   	(bad)  
    3b4f:	ff                   	(bad)  
    3b50:	ff                   	(bad)  
    3b51:	ff                   	(bad)  
    3b52:	ff                   	(bad)  
    3b53:	ff                   	(bad)  
    3b54:	ff                   	(bad)  
    3b55:	ff                   	(bad)  
    3b56:	ff                   	(bad)  
    3b57:	ff                   	(bad)  
    3b58:	ff                   	(bad)  
    3b59:	ff                   	(bad)  
    3b5a:	ff                   	(bad)  
    3b5b:	ff                   	(bad)  
    3b5c:	ff                   	(bad)  
    3b5d:	ff                   	(bad)  
    3b5e:	ff                   	(bad)  
    3b5f:	ff                   	(bad)  
    3b60:	ff                   	(bad)  
    3b61:	ff                   	(bad)  
    3b62:	ff                   	(bad)  
    3b63:	ff                   	(bad)  
    3b64:	ff                   	(bad)  
    3b65:	ff                   	(bad)  
    3b66:	ff                   	(bad)  
    3b67:	ff                   	(bad)  
    3b68:	ff                   	(bad)  
    3b69:	ff                   	(bad)  
    3b6a:	ff                   	(bad)  
    3b6b:	ff                   	(bad)  
    3b6c:	ff                   	(bad)  
    3b6d:	ff                   	(bad)  
    3b6e:	ff                   	(bad)  
    3b6f:	ff                   	(bad)  
    3b70:	ff                   	(bad)  
    3b71:	ff                   	(bad)  
    3b72:	ff                   	(bad)  
    3b73:	ff                   	(bad)  
    3b74:	ff                   	(bad)  
    3b75:	ff                   	(bad)  
    3b76:	ff                   	(bad)  
    3b77:	ff                   	(bad)  
    3b78:	ff                   	(bad)  
    3b79:	ff                   	(bad)  
    3b7a:	ff                   	(bad)  
    3b7b:	ff                   	(bad)  
    3b7c:	ff                   	(bad)  
    3b7d:	ff                   	(bad)  
    3b7e:	ff                   	(bad)  
    3b7f:	ff                   	(bad)  
    3b80:	ff                   	(bad)  
    3b81:	ff                   	(bad)  
    3b82:	ff                   	(bad)  
    3b83:	ff                   	(bad)  
    3b84:	ff                   	(bad)  
    3b85:	ff                   	(bad)  
    3b86:	ff                   	(bad)  
    3b87:	ff                   	(bad)  
    3b88:	ff                   	(bad)  
    3b89:	ff                   	(bad)  
    3b8a:	ff                   	(bad)  
    3b8b:	ff                   	(bad)  
    3b8c:	ff                   	(bad)  
    3b8d:	ff                   	(bad)  
    3b8e:	ff                   	(bad)  
    3b8f:	ff                   	(bad)  
    3b90:	ff                   	(bad)  
    3b91:	ff                   	(bad)  
    3b92:	ff                   	(bad)  
    3b93:	ff                   	(bad)  
    3b94:	ff                   	(bad)  
    3b95:	ff                   	(bad)  
    3b96:	ff                   	(bad)  
    3b97:	ff                   	(bad)  
    3b98:	ff                   	(bad)  
    3b99:	ff                   	(bad)  
    3b9a:	ff                   	(bad)  
    3b9b:	ff                   	(bad)  
    3b9c:	ff                   	(bad)  
    3b9d:	ff                   	(bad)  
    3b9e:	ff                   	(bad)  
    3b9f:	ff                   	(bad)  
    3ba0:	ff                   	(bad)  
    3ba1:	ff                   	(bad)  
    3ba2:	ff                   	(bad)  
    3ba3:	ff                   	(bad)  
    3ba4:	ff                   	(bad)  
    3ba5:	ff                   	(bad)  
    3ba6:	ff                   	(bad)  
    3ba7:	ff                   	(bad)  
    3ba8:	ff                   	(bad)  
    3ba9:	ff                   	(bad)  
    3baa:	ff                   	(bad)  
    3bab:	ff                   	(bad)  
    3bac:	ff                   	(bad)  
    3bad:	ff                   	(bad)  
    3bae:	ff                   	(bad)  
    3baf:	ff                   	(bad)  
    3bb0:	ff                   	(bad)  
    3bb1:	ff                   	(bad)  
    3bb2:	ff                   	(bad)  
    3bb3:	ff                   	(bad)  
    3bb4:	ff                   	(bad)  
    3bb5:	ff                   	(bad)  
    3bb6:	ff                   	(bad)  
    3bb7:	ff                   	(bad)  
    3bb8:	ff                   	(bad)  
    3bb9:	ff                   	(bad)  
    3bba:	ff                   	(bad)  
    3bbb:	ff                   	(bad)  
    3bbc:	ff                   	(bad)  
    3bbd:	ff                   	(bad)  
    3bbe:	ff                   	(bad)  
    3bbf:	ff                   	(bad)  
    3bc0:	ff                   	(bad)  
    3bc1:	ff                   	(bad)  
    3bc2:	ff                   	(bad)  
    3bc3:	ff                   	(bad)  
    3bc4:	ff                   	(bad)  
    3bc5:	ff                   	(bad)  
    3bc6:	ff                   	(bad)  
    3bc7:	ff                   	(bad)  
    3bc8:	ff                   	(bad)  
    3bc9:	ff                   	(bad)  
    3bca:	ff                   	(bad)  
    3bcb:	ff                   	(bad)  
    3bcc:	ff                   	(bad)  
    3bcd:	ff                   	(bad)  
    3bce:	ff                   	(bad)  
    3bcf:	ff                   	(bad)  
    3bd0:	ff                   	(bad)  
    3bd1:	ff                   	(bad)  
    3bd2:	ff                   	(bad)  
    3bd3:	ff                   	(bad)  
    3bd4:	ff                   	(bad)  
    3bd5:	ff                   	(bad)  
    3bd6:	ff                   	(bad)  
    3bd7:	ff                   	(bad)  
    3bd8:	ff                   	(bad)  
    3bd9:	ff                   	(bad)  
    3bda:	ff                   	(bad)  
    3bdb:	ff                   	(bad)  
    3bdc:	ff                   	(bad)  
    3bdd:	ff                   	(bad)  
    3bde:	ff                   	(bad)  
    3bdf:	ff                   	(bad)  
    3be0:	ff                   	(bad)  
    3be1:	ff                   	(bad)  
    3be2:	ff                   	(bad)  
    3be3:	ff                   	(bad)  
    3be4:	ff                   	(bad)  
    3be5:	ff                   	(bad)  
    3be6:	ff                   	(bad)  
    3be7:	ff                   	(bad)  
    3be8:	ff                   	(bad)  
    3be9:	ff                   	(bad)  
    3bea:	ff                   	(bad)  
    3beb:	ff                   	(bad)  
    3bec:	ff                   	(bad)  
    3bed:	ff                   	(bad)  
    3bee:	ff                   	(bad)  
    3bef:	ff                   	(bad)  
    3bf0:	ff                   	(bad)  
    3bf1:	ff                   	(bad)  
    3bf2:	ff                   	(bad)  
    3bf3:	ff                   	(bad)  
    3bf4:	ff                   	(bad)  
    3bf5:	ff                   	(bad)  
    3bf6:	ff                   	(bad)  
    3bf7:	ff                   	(bad)  
    3bf8:	ff                   	(bad)  
    3bf9:	ff                   	(bad)  
    3bfa:	ff                   	(bad)  
    3bfb:	ff                   	(bad)  
    3bfc:	ff                   	(bad)  
    3bfd:	ff                   	(bad)  
    3bfe:	ff                   	(bad)  
    3bff:	ff                   	(bad)  
    3c00:	ff                   	(bad)  
    3c01:	ff                   	(bad)  
    3c02:	ff                   	(bad)  
    3c03:	ff                   	(bad)  
    3c04:	ff                   	(bad)  
    3c05:	ff                   	(bad)  
    3c06:	ff                   	(bad)  
    3c07:	ff                   	(bad)  
    3c08:	ff                   	(bad)  
    3c09:	ff                   	(bad)  
    3c0a:	ff                   	(bad)  
    3c0b:	ff                   	(bad)  
    3c0c:	ff                   	(bad)  
    3c0d:	ff                   	(bad)  
    3c0e:	ff                   	(bad)  
    3c0f:	ff                   	(bad)  
    3c10:	ff                   	(bad)  
    3c11:	ff                   	(bad)  
    3c12:	ff                   	(bad)  
    3c13:	ff                   	(bad)  
    3c14:	ff                   	(bad)  
    3c15:	ff                   	(bad)  
    3c16:	ff                   	(bad)  
    3c17:	ff                   	(bad)  
    3c18:	ff                   	(bad)  
    3c19:	ff                   	(bad)  
    3c1a:	ff                   	(bad)  
    3c1b:	ff                   	(bad)  
    3c1c:	ff                   	(bad)  
    3c1d:	ff                   	(bad)  
    3c1e:	ff                   	(bad)  
    3c1f:	ff                   	(bad)  
    3c20:	ff                   	(bad)  
    3c21:	ff                   	(bad)  
    3c22:	ff                   	(bad)  
    3c23:	ff                   	(bad)  
    3c24:	ff                   	(bad)  
    3c25:	ff                   	(bad)  
    3c26:	ff                   	(bad)  
    3c27:	ff                   	(bad)  
    3c28:	ff                   	(bad)  
    3c29:	ff                   	(bad)  
    3c2a:	ff                   	(bad)  
    3c2b:	ff                   	(bad)  
    3c2c:	ff                   	(bad)  
    3c2d:	ff                   	(bad)  
    3c2e:	ff                   	(bad)  
    3c2f:	ff                   	(bad)  
    3c30:	ff                   	(bad)  
    3c31:	ff                   	(bad)  
    3c32:	ff                   	(bad)  
    3c33:	ff                   	(bad)  
    3c34:	ff                   	(bad)  
    3c35:	ff                   	(bad)  
    3c36:	ff                   	(bad)  
    3c37:	ff                   	(bad)  
    3c38:	ff                   	(bad)  
    3c39:	ff                   	(bad)  
    3c3a:	ff                   	(bad)  
    3c3b:	ff                   	(bad)  
    3c3c:	ff                   	(bad)  
    3c3d:	ff                   	(bad)  
    3c3e:	ff                   	(bad)  
    3c3f:	ff                   	(bad)  
    3c40:	ff                   	(bad)  
    3c41:	ff                   	(bad)  
    3c42:	ff                   	(bad)  
    3c43:	ff                   	(bad)  
    3c44:	ff                   	(bad)  
    3c45:	ff                   	(bad)  
    3c46:	ff                   	(bad)  
    3c47:	ff                   	(bad)  
    3c48:	ff                   	(bad)  
    3c49:	ff                   	(bad)  
    3c4a:	ff                   	(bad)  
    3c4b:	ff                   	(bad)  
    3c4c:	ff                   	(bad)  
    3c4d:	ff                   	(bad)  
    3c4e:	ff                   	(bad)  
    3c4f:	ff                   	(bad)  
    3c50:	ff                   	(bad)  
    3c51:	ff                   	(bad)  
    3c52:	ff                   	(bad)  
    3c53:	ff                   	(bad)  
    3c54:	ff                   	(bad)  
    3c55:	ff                   	(bad)  
    3c56:	ff                   	(bad)  
    3c57:	ff                   	(bad)  
    3c58:	ff                   	(bad)  
    3c59:	ff                   	(bad)  
    3c5a:	ff                   	(bad)  
    3c5b:	ff                   	(bad)  
    3c5c:	ff                   	(bad)  
    3c5d:	ff                   	(bad)  
    3c5e:	ff                   	(bad)  
    3c5f:	ff                   	(bad)  
    3c60:	ff                   	(bad)  
    3c61:	ff                   	(bad)  
    3c62:	ff                   	(bad)  
    3c63:	ff                   	(bad)  
    3c64:	ff                   	(bad)  
    3c65:	ff                   	(bad)  
    3c66:	ff                   	(bad)  
    3c67:	ff                   	(bad)  
    3c68:	ff                   	(bad)  
    3c69:	ff                   	(bad)  
    3c6a:	ff                   	(bad)  
    3c6b:	ff                   	(bad)  
    3c6c:	ff                   	(bad)  
    3c6d:	ff                   	(bad)  
    3c6e:	ff                   	(bad)  
    3c6f:	ff                   	(bad)  
    3c70:	ff                   	(bad)  
    3c71:	ff                   	(bad)  
    3c72:	ff                   	(bad)  
    3c73:	ff                   	(bad)  
    3c74:	ff                   	(bad)  
    3c75:	ff                   	(bad)  
    3c76:	ff                   	(bad)  
    3c77:	ff                   	(bad)  
    3c78:	ff                   	(bad)  
    3c79:	ff                   	(bad)  
    3c7a:	ff                   	(bad)  
    3c7b:	ff                   	(bad)  
    3c7c:	ff                   	(bad)  
    3c7d:	ff                   	(bad)  
    3c7e:	ff                   	(bad)  
    3c7f:	ff                   	(bad)  
    3c80:	ff                   	(bad)  
    3c81:	ff                   	(bad)  
    3c82:	ff                   	(bad)  
    3c83:	ff                   	(bad)  
    3c84:	ff                   	(bad)  
    3c85:	ff                   	(bad)  
    3c86:	ff                   	(bad)  
    3c87:	ff                   	(bad)  
    3c88:	ff                   	(bad)  
    3c89:	ff                   	(bad)  
    3c8a:	ff                   	(bad)  
    3c8b:	ff                   	(bad)  
    3c8c:	ff                   	(bad)  
    3c8d:	ff                   	(bad)  
    3c8e:	ff                   	(bad)  
    3c8f:	ff                   	(bad)  
    3c90:	ff                   	(bad)  
    3c91:	ff                   	(bad)  
    3c92:	ff                   	(bad)  
    3c93:	ff                   	(bad)  
    3c94:	ff                   	(bad)  
    3c95:	ff                   	(bad)  
    3c96:	ff                   	(bad)  
    3c97:	ff                   	(bad)  
    3c98:	ff                   	(bad)  
    3c99:	ff                   	(bad)  
    3c9a:	ff                   	(bad)  
    3c9b:	ff                   	(bad)  
    3c9c:	ff                   	(bad)  
    3c9d:	ff                   	(bad)  
    3c9e:	ff                   	(bad)  
    3c9f:	ff                   	(bad)  
    3ca0:	ff                   	(bad)  
    3ca1:	ff                   	(bad)  
    3ca2:	ff                   	(bad)  
    3ca3:	ff                   	(bad)  
    3ca4:	ff                   	(bad)  
    3ca5:	ff                   	(bad)  
    3ca6:	ff                   	(bad)  
    3ca7:	ff                   	(bad)  
    3ca8:	ff                   	(bad)  
    3ca9:	ff                   	(bad)  
    3caa:	ff                   	(bad)  
    3cab:	ff                   	(bad)  
    3cac:	ff                   	(bad)  
    3cad:	ff                   	(bad)  
    3cae:	ff                   	(bad)  
    3caf:	ff                   	(bad)  
    3cb0:	ff                   	(bad)  
    3cb1:	ff                   	(bad)  
    3cb2:	ff                   	(bad)  
    3cb3:	ff                   	(bad)  
    3cb4:	ff                   	(bad)  
    3cb5:	ff                   	(bad)  
    3cb6:	ff                   	(bad)  
    3cb7:	ff                   	(bad)  
    3cb8:	ff                   	(bad)  
    3cb9:	ff                   	(bad)  
    3cba:	ff                   	(bad)  
    3cbb:	ff                   	(bad)  
    3cbc:	ff                   	(bad)  
    3cbd:	ff                   	(bad)  
    3cbe:	ff                   	(bad)  
    3cbf:	ff                   	(bad)  
    3cc0:	ff                   	(bad)  
    3cc1:	ff                   	(bad)  
    3cc2:	ff                   	(bad)  
    3cc3:	ff                   	(bad)  
    3cc4:	ff                   	(bad)  
    3cc5:	ff                   	(bad)  
    3cc6:	ff                   	(bad)  
    3cc7:	ff                   	(bad)  
    3cc8:	ff                   	(bad)  
    3cc9:	ff                   	(bad)  
    3cca:	ff                   	(bad)  
    3ccb:	ff                   	(bad)  
    3ccc:	ff                   	(bad)  
    3ccd:	ff                   	(bad)  
    3cce:	ff                   	(bad)  
    3ccf:	ff                   	(bad)  
    3cd0:	ff                   	(bad)  
    3cd1:	ff                   	(bad)  
    3cd2:	ff                   	(bad)  
    3cd3:	ff                   	(bad)  
    3cd4:	ff                   	(bad)  
    3cd5:	ff                   	(bad)  
    3cd6:	ff                   	(bad)  
    3cd7:	ff                   	(bad)  
    3cd8:	ff                   	(bad)  
    3cd9:	ff                   	(bad)  
    3cda:	ff                   	(bad)  
    3cdb:	ff                   	(bad)  
    3cdc:	ff                   	(bad)  
    3cdd:	ff                   	(bad)  
    3cde:	ff                   	(bad)  
    3cdf:	ff                   	(bad)  
    3ce0:	ff                   	(bad)  
    3ce1:	ff                   	(bad)  
    3ce2:	ff                   	(bad)  
    3ce3:	ff                   	(bad)  
    3ce4:	ff                   	(bad)  
    3ce5:	ff                   	(bad)  
    3ce6:	ff                   	(bad)  
    3ce7:	ff                   	(bad)  
    3ce8:	ff                   	(bad)  
    3ce9:	ff                   	(bad)  
    3cea:	ff                   	(bad)  
    3ceb:	ff                   	(bad)  
    3cec:	ff                   	(bad)  
    3ced:	ff                   	(bad)  
    3cee:	ff                   	(bad)  
    3cef:	ff                   	(bad)  
    3cf0:	ff                   	(bad)  
    3cf1:	ff                   	(bad)  
    3cf2:	ff                   	(bad)  
    3cf3:	ff                   	(bad)  
    3cf4:	ff                   	(bad)  
    3cf5:	ff                   	(bad)  
    3cf6:	ff                   	(bad)  
    3cf7:	ff                   	(bad)  
    3cf8:	ff                   	(bad)  
    3cf9:	ff                   	(bad)  
    3cfa:	ff                   	(bad)  
    3cfb:	ff                   	(bad)  
    3cfc:	ff                   	(bad)  
    3cfd:	ff                   	(bad)  
    3cfe:	ff                   	(bad)  
    3cff:	ff                   	(bad)  
    3d00:	ff                   	(bad)  
    3d01:	ff                   	(bad)  
    3d02:	ff                   	(bad)  
    3d03:	ff                   	(bad)  
    3d04:	ff                   	(bad)  
    3d05:	ff                   	(bad)  
    3d06:	ff                   	(bad)  
    3d07:	ff                   	(bad)  
    3d08:	ff                   	(bad)  
    3d09:	ff                   	(bad)  
    3d0a:	ff                   	(bad)  
    3d0b:	ff                   	(bad)  
    3d0c:	ff                   	(bad)  
    3d0d:	ff                   	(bad)  
    3d0e:	ff                   	(bad)  
    3d0f:	ff                   	(bad)  
    3d10:	ff                   	(bad)  
    3d11:	ff                   	(bad)  
    3d12:	ff                   	(bad)  
    3d13:	ff                   	(bad)  
    3d14:	ff                   	(bad)  
    3d15:	ff                   	(bad)  
    3d16:	ff                   	(bad)  
    3d17:	ff                   	(bad)  
    3d18:	ff                   	(bad)  
    3d19:	ff                   	(bad)  
    3d1a:	ff                   	(bad)  
    3d1b:	ff                   	(bad)  
    3d1c:	ff                   	(bad)  
    3d1d:	ff                   	(bad)  
    3d1e:	ff                   	(bad)  
    3d1f:	ff                   	(bad)  
    3d20:	ff                   	(bad)  
    3d21:	ff                   	(bad)  
    3d22:	ff                   	(bad)  
    3d23:	ff                   	(bad)  
    3d24:	ff                   	(bad)  
    3d25:	ff                   	(bad)  
    3d26:	ff                   	(bad)  
    3d27:	ff                   	(bad)  
    3d28:	ff                   	(bad)  
    3d29:	ff                   	(bad)  
    3d2a:	ff                   	(bad)  
    3d2b:	ff                   	(bad)  
    3d2c:	ff                   	(bad)  
    3d2d:	ff                   	(bad)  
    3d2e:	ff                   	(bad)  
    3d2f:	ff                   	(bad)  
    3d30:	ff                   	(bad)  
    3d31:	ff                   	(bad)  
    3d32:	ff                   	(bad)  
    3d33:	ff                   	(bad)  
    3d34:	ff                   	(bad)  
    3d35:	ff                   	(bad)  
    3d36:	ff                   	(bad)  
    3d37:	ff                   	(bad)  
    3d38:	ff                   	(bad)  
    3d39:	ff                   	(bad)  
    3d3a:	ff                   	(bad)  
    3d3b:	ff                   	(bad)  
    3d3c:	ff                   	(bad)  
    3d3d:	ff                   	(bad)  
    3d3e:	ff                   	(bad)  
    3d3f:	ff                   	(bad)  
    3d40:	ff                   	(bad)  
    3d41:	ff                   	(bad)  
    3d42:	ff                   	(bad)  
    3d43:	ff                   	(bad)  
    3d44:	ff                   	(bad)  
    3d45:	ff                   	(bad)  
    3d46:	ff                   	(bad)  
    3d47:	ff                   	(bad)  
    3d48:	ff                   	(bad)  
    3d49:	ff                   	(bad)  
    3d4a:	ff                   	(bad)  
    3d4b:	ff                   	(bad)  
    3d4c:	ff                   	(bad)  
    3d4d:	ff                   	(bad)  
    3d4e:	ff                   	(bad)  
    3d4f:	ff                   	(bad)  
    3d50:	ff                   	(bad)  
    3d51:	ff                   	(bad)  
    3d52:	ff                   	(bad)  
    3d53:	ff                   	(bad)  
    3d54:	ff                   	(bad)  
    3d55:	ff                   	(bad)  
    3d56:	ff                   	(bad)  
    3d57:	ff                   	(bad)  
    3d58:	ff                   	(bad)  
    3d59:	ff                   	(bad)  
    3d5a:	ff                   	(bad)  
    3d5b:	ff                   	(bad)  
    3d5c:	ff                   	(bad)  
    3d5d:	ff                   	(bad)  
    3d5e:	ff                   	(bad)  
    3d5f:	ff                   	(bad)  
    3d60:	ff                   	(bad)  
    3d61:	ff                   	(bad)  
    3d62:	ff                   	(bad)  
    3d63:	ff                   	(bad)  
    3d64:	ff                   	(bad)  
    3d65:	ff                   	(bad)  
    3d66:	ff                   	(bad)  
    3d67:	ff                   	(bad)  
    3d68:	ff                   	(bad)  
    3d69:	ff                   	(bad)  
    3d6a:	ff                   	(bad)  
    3d6b:	ff                   	(bad)  
    3d6c:	ff                   	(bad)  
    3d6d:	ff                   	(bad)  
    3d6e:	ff                   	(bad)  
    3d6f:	ff                   	(bad)  
    3d70:	ff                   	(bad)  
    3d71:	ff                   	(bad)  
    3d72:	ff                   	(bad)  
    3d73:	ff                   	(bad)  
    3d74:	ff                   	(bad)  
    3d75:	ff                   	(bad)  
    3d76:	ff                   	(bad)  
    3d77:	ff                   	(bad)  
    3d78:	ff                   	(bad)  
    3d79:	ff                   	(bad)  
    3d7a:	ff                   	(bad)  
    3d7b:	ff                   	(bad)  
    3d7c:	ff                   	(bad)  
    3d7d:	ff                   	(bad)  
    3d7e:	ff                   	(bad)  
    3d7f:	ff                   	(bad)  
    3d80:	ff                   	(bad)  
    3d81:	ff                   	(bad)  
    3d82:	ff                   	(bad)  
    3d83:	ff                   	(bad)  
    3d84:	ff                   	(bad)  
    3d85:	ff                   	(bad)  
    3d86:	ff                   	(bad)  
    3d87:	ff                   	(bad)  
    3d88:	ff                   	(bad)  
    3d89:	ff                   	(bad)  
    3d8a:	ff                   	(bad)  
    3d8b:	ff                   	(bad)  
    3d8c:	ff                   	(bad)  
    3d8d:	ff                   	(bad)  
    3d8e:	ff                   	(bad)  
    3d8f:	ff                   	(bad)  
    3d90:	ff                   	(bad)  
    3d91:	ff                   	(bad)  
    3d92:	ff                   	(bad)  
    3d93:	ff                   	(bad)  
    3d94:	ff                   	(bad)  
    3d95:	ff                   	(bad)  
    3d96:	ff                   	(bad)  
    3d97:	ff                   	(bad)  
    3d98:	ff                   	(bad)  
    3d99:	ff                   	(bad)  
    3d9a:	ff                   	(bad)  
    3d9b:	ff                   	(bad)  
    3d9c:	ff                   	(bad)  
    3d9d:	ff                   	(bad)  
    3d9e:	ff                   	(bad)  
    3d9f:	ff                   	(bad)  
    3da0:	ff                   	(bad)  
    3da1:	ff                   	(bad)  
    3da2:	ff                   	(bad)  
    3da3:	ff                   	(bad)  
    3da4:	ff                   	(bad)  
    3da5:	ff                   	(bad)  
    3da6:	ff                   	(bad)  
    3da7:	ff                   	(bad)  
    3da8:	ff                   	(bad)  
    3da9:	ff                   	(bad)  
    3daa:	ff                   	(bad)  
    3dab:	ff                   	(bad)  
    3dac:	ff                   	(bad)  
    3dad:	ff                   	(bad)  
    3dae:	ff                   	(bad)  
    3daf:	ff                   	(bad)  
    3db0:	ff                   	(bad)  
    3db1:	ff                   	(bad)  
    3db2:	ff                   	(bad)  
    3db3:	ff                   	(bad)  
    3db4:	ff                   	(bad)  
    3db5:	ff                   	(bad)  
    3db6:	ff                   	(bad)  
    3db7:	ff                   	(bad)  
    3db8:	ff                   	(bad)  
    3db9:	ff                   	(bad)  
    3dba:	ff                   	(bad)  
    3dbb:	ff                   	(bad)  
    3dbc:	ff                   	(bad)  
    3dbd:	ff                   	(bad)  
    3dbe:	ff                   	(bad)  
    3dbf:	ff                   	(bad)  
    3dc0:	ff                   	(bad)  
    3dc1:	ff                   	(bad)  
    3dc2:	ff                   	(bad)  
    3dc3:	ff                   	(bad)  
    3dc4:	ff                   	(bad)  
    3dc5:	ff                   	(bad)  
    3dc6:	ff                   	(bad)  
    3dc7:	ff                   	(bad)  
    3dc8:	ff                   	(bad)  
    3dc9:	ff                   	(bad)  
    3dca:	ff                   	(bad)  
    3dcb:	ff                   	(bad)  
    3dcc:	ff                   	(bad)  
    3dcd:	ff                   	(bad)  
    3dce:	ff                   	(bad)  
    3dcf:	ff                   	(bad)  
    3dd0:	ff                   	(bad)  
    3dd1:	ff                   	(bad)  
    3dd2:	ff                   	(bad)  
    3dd3:	ff                   	(bad)  
    3dd4:	ff                   	(bad)  
    3dd5:	ff                   	(bad)  
    3dd6:	ff                   	(bad)  
    3dd7:	ff                   	(bad)  
    3dd8:	ff                   	(bad)  
    3dd9:	ff                   	(bad)  
    3dda:	ff                   	(bad)  
    3ddb:	ff                   	(bad)  
    3ddc:	ff                   	(bad)  
    3ddd:	ff                   	(bad)  
    3dde:	ff                   	(bad)  
    3ddf:	ff                   	(bad)  
    3de0:	ff                   	(bad)  
    3de1:	ff                   	(bad)  
    3de2:	ff                   	(bad)  
    3de3:	ff                   	(bad)  
    3de4:	ff                   	(bad)  
    3de5:	ff                   	(bad)  
    3de6:	ff                   	(bad)  
    3de7:	ff                   	(bad)  
    3de8:	ff                   	(bad)  
    3de9:	ff                   	(bad)  
    3dea:	ff                   	(bad)  
    3deb:	ff                   	(bad)  
    3dec:	ff                   	(bad)  
    3ded:	ff                   	(bad)  
    3dee:	ff                   	(bad)  
    3def:	ff                   	(bad)  
    3df0:	ff                   	(bad)  
    3df1:	ff                   	(bad)  
    3df2:	ff                   	(bad)  
    3df3:	ff                   	(bad)  
    3df4:	ff                   	(bad)  
    3df5:	ff                   	(bad)  
    3df6:	ff                   	(bad)  
    3df7:	ff                   	(bad)  
    3df8:	ff                   	(bad)  
    3df9:	ff                   	(bad)  
    3dfa:	ff                   	(bad)  
    3dfb:	ff                   	(bad)  
    3dfc:	ff                   	(bad)  
    3dfd:	ff                   	(bad)  
    3dfe:	ff                   	(bad)  
    3dff:	ff                   	(bad)  
    3e00:	ff                   	(bad)  
    3e01:	ff                   	(bad)  
    3e02:	ff                   	(bad)  
    3e03:	ff                   	(bad)  
    3e04:	ff                   	(bad)  
    3e05:	ff                   	(bad)  
    3e06:	ff                   	(bad)  
    3e07:	ff                   	(bad)  
    3e08:	ff                   	(bad)  
    3e09:	ff                   	(bad)  
    3e0a:	ff                   	(bad)  
    3e0b:	ff                   	(bad)  
    3e0c:	ff                   	(bad)  
    3e0d:	ff                   	(bad)  
    3e0e:	ff                   	(bad)  
    3e0f:	ff                   	(bad)  
    3e10:	ff                   	(bad)  
    3e11:	ff                   	(bad)  
    3e12:	ff                   	(bad)  
    3e13:	ff                   	(bad)  
    3e14:	ff                   	(bad)  
    3e15:	ff                   	(bad)  
    3e16:	ff                   	(bad)  
    3e17:	ff                   	(bad)  
    3e18:	ff                   	(bad)  
    3e19:	ff                   	(bad)  
    3e1a:	ff                   	(bad)  
    3e1b:	ff                   	(bad)  
    3e1c:	ff                   	(bad)  
    3e1d:	ff                   	(bad)  
    3e1e:	ff                   	(bad)  
    3e1f:	ff                   	(bad)  
    3e20:	ff                   	(bad)  
    3e21:	ff                   	(bad)  
    3e22:	ff                   	(bad)  
    3e23:	ff                   	(bad)  
    3e24:	ff                   	(bad)  
    3e25:	ff                   	(bad)  
    3e26:	ff                   	(bad)  
    3e27:	ff                   	(bad)  
    3e28:	ff                   	(bad)  
    3e29:	ff                   	(bad)  
    3e2a:	ff                   	(bad)  
    3e2b:	ff                   	(bad)  
    3e2c:	ff                   	(bad)  
    3e2d:	ff                   	(bad)  
    3e2e:	ff                   	(bad)  
    3e2f:	ff                   	(bad)  
    3e30:	ff                   	(bad)  
    3e31:	ff                   	(bad)  
    3e32:	ff                   	(bad)  
    3e33:	ff                   	(bad)  
    3e34:	ff                   	(bad)  
    3e35:	ff                   	(bad)  
    3e36:	ff                   	(bad)  
    3e37:	ff                   	(bad)  
    3e38:	ff                   	(bad)  
    3e39:	ff                   	(bad)  
    3e3a:	ff                   	(bad)  
    3e3b:	ff                   	(bad)  
    3e3c:	ff                   	(bad)  
    3e3d:	ff                   	(bad)  
    3e3e:	ff                   	(bad)  
    3e3f:	ff                   	(bad)  
    3e40:	ff                   	(bad)  
    3e41:	ff                   	(bad)  
    3e42:	ff                   	(bad)  
    3e43:	ff                   	(bad)  
    3e44:	ff                   	(bad)  
    3e45:	ff                   	(bad)  
    3e46:	ff                   	(bad)  
    3e47:	ff                   	(bad)  
    3e48:	ff                   	(bad)  
    3e49:	ff                   	(bad)  
    3e4a:	ff                   	(bad)  
    3e4b:	ff                   	(bad)  
    3e4c:	ff                   	(bad)  
    3e4d:	ff                   	(bad)  
    3e4e:	ff                   	(bad)  
    3e4f:	ff                   	(bad)  
    3e50:	ff                   	(bad)  
    3e51:	ff                   	(bad)  
    3e52:	ff                   	(bad)  
    3e53:	ff                   	(bad)  
    3e54:	ff                   	(bad)  
    3e55:	ff                   	(bad)  
    3e56:	ff                   	(bad)  
    3e57:	ff                   	(bad)  
    3e58:	ff                   	(bad)  
    3e59:	ff                   	(bad)  
    3e5a:	ff                   	(bad)  
    3e5b:	ff                   	(bad)  
    3e5c:	ff                   	(bad)  
    3e5d:	ff                   	(bad)  
    3e5e:	ff                   	(bad)  
    3e5f:	ff                   	(bad)  
    3e60:	ff                   	(bad)  
    3e61:	ff                   	(bad)  
    3e62:	ff                   	(bad)  
    3e63:	ff                   	(bad)  
    3e64:	ff                   	(bad)  
    3e65:	ff                   	(bad)  
    3e66:	ff                   	(bad)  
    3e67:	ff                   	(bad)  
    3e68:	ff                   	(bad)  
    3e69:	ff                   	(bad)  
    3e6a:	ff                   	(bad)  
    3e6b:	ff                   	(bad)  
    3e6c:	ff                   	(bad)  
    3e6d:	ff                   	(bad)  
    3e6e:	ff                   	(bad)  
    3e6f:	ff                   	(bad)  
    3e70:	ff                   	(bad)  
    3e71:	ff                   	(bad)  
    3e72:	ff                   	(bad)  
    3e73:	ff                   	(bad)  
    3e74:	ff                   	(bad)  
    3e75:	ff                   	(bad)  
    3e76:	ff                   	(bad)  
    3e77:	ff                   	(bad)  
    3e78:	ff                   	(bad)  
    3e79:	ff                   	(bad)  
    3e7a:	ff                   	(bad)  
    3e7b:	ff                   	(bad)  
    3e7c:	ff                   	(bad)  
    3e7d:	ff                   	(bad)  
    3e7e:	ff                   	(bad)  
    3e7f:	ff                   	(bad)  
    3e80:	ff                   	(bad)  
    3e81:	ff                   	(bad)  
    3e82:	ff                   	(bad)  
    3e83:	ff                   	(bad)  
    3e84:	ff                   	(bad)  
    3e85:	ff                   	(bad)  
    3e86:	ff                   	(bad)  
    3e87:	ff                   	(bad)  
    3e88:	ff                   	(bad)  
    3e89:	ff                   	(bad)  
    3e8a:	ff                   	(bad)  
    3e8b:	ff                   	(bad)  
    3e8c:	ff                   	(bad)  
    3e8d:	ff                   	(bad)  
    3e8e:	ff                   	(bad)  
    3e8f:	ff                   	(bad)  
    3e90:	ff                   	(bad)  
    3e91:	ff                   	(bad)  
    3e92:	ff                   	(bad)  
    3e93:	ff                   	(bad)  
    3e94:	ff                   	(bad)  
    3e95:	ff                   	(bad)  
    3e96:	ff                   	(bad)  
    3e97:	ff                   	(bad)  
    3e98:	ff                   	(bad)  
    3e99:	ff                   	(bad)  
    3e9a:	ff                   	(bad)  
    3e9b:	ff                   	(bad)  
    3e9c:	ff                   	(bad)  
    3e9d:	ff                   	(bad)  
    3e9e:	ff                   	(bad)  
    3e9f:	ff                   	(bad)  
    3ea0:	ff                   	(bad)  
    3ea1:	ff                   	(bad)  
    3ea2:	ff                   	(bad)  
    3ea3:	ff                   	(bad)  
    3ea4:	ff                   	(bad)  
    3ea5:	ff                   	(bad)  
    3ea6:	ff                   	(bad)  
    3ea7:	ff                   	(bad)  
    3ea8:	ff                   	(bad)  
    3ea9:	ff                   	(bad)  
    3eaa:	ff                   	(bad)  
    3eab:	ff                   	(bad)  
    3eac:	ff                   	(bad)  
    3ead:	ff                   	(bad)  
    3eae:	ff                   	(bad)  
    3eaf:	ff                   	(bad)  
    3eb0:	ff                   	(bad)  
    3eb1:	ff                   	(bad)  
    3eb2:	ff                   	(bad)  
    3eb3:	ff                   	(bad)  
    3eb4:	ff                   	(bad)  
    3eb5:	ff                   	(bad)  
    3eb6:	ff                   	(bad)  
    3eb7:	ff                   	(bad)  
    3eb8:	ff                   	(bad)  
    3eb9:	ff                   	(bad)  
    3eba:	ff                   	(bad)  
    3ebb:	ff                   	(bad)  
    3ebc:	ff                   	(bad)  
    3ebd:	ff                   	(bad)  
    3ebe:	ff                   	(bad)  
    3ebf:	ff                   	(bad)  
    3ec0:	ff                   	(bad)  
    3ec1:	ff                   	(bad)  
    3ec2:	ff                   	(bad)  
    3ec3:	ff                   	(bad)  
    3ec4:	ff                   	(bad)  
    3ec5:	ff                   	(bad)  
    3ec6:	ff                   	(bad)  
    3ec7:	ff                   	(bad)  
    3ec8:	ff                   	(bad)  
    3ec9:	ff                   	(bad)  
    3eca:	ff                   	(bad)  
    3ecb:	ff                   	(bad)  
    3ecc:	ff                   	(bad)  
    3ecd:	ff                   	(bad)  
    3ece:	ff                   	(bad)  
    3ecf:	ff                   	(bad)  
    3ed0:	ff                   	(bad)  
    3ed1:	ff                   	(bad)  
    3ed2:	ff                   	(bad)  
    3ed3:	ff                   	(bad)  
    3ed4:	ff                   	(bad)  
    3ed5:	ff                   	(bad)  
    3ed6:	ff                   	(bad)  
    3ed7:	ff                   	(bad)  
    3ed8:	ff                   	(bad)  
    3ed9:	ff                   	(bad)  
    3eda:	ff                   	(bad)  
    3edb:	ff                   	(bad)  
    3edc:	ff                   	(bad)  
    3edd:	ff                   	(bad)  
    3ede:	ff                   	(bad)  
    3edf:	ff                   	(bad)  
    3ee0:	ff                   	(bad)  
    3ee1:	ff                   	(bad)  
    3ee2:	ff                   	(bad)  
    3ee3:	ff                   	(bad)  
    3ee4:	ff                   	(bad)  
    3ee5:	ff                   	(bad)  
    3ee6:	ff                   	(bad)  
    3ee7:	ff                   	(bad)  
    3ee8:	ff                   	(bad)  
    3ee9:	ff                   	(bad)  
    3eea:	ff                   	(bad)  
    3eeb:	ff                   	(bad)  
    3eec:	ff                   	(bad)  
    3eed:	ff                   	(bad)  
    3eee:	ff                   	(bad)  
    3eef:	ff                   	(bad)  
    3ef0:	ff                   	(bad)  
    3ef1:	ff                   	(bad)  
    3ef2:	ff                   	(bad)  
    3ef3:	ff                   	(bad)  
    3ef4:	ff                   	(bad)  
    3ef5:	ff                   	(bad)  
    3ef6:	ff                   	(bad)  
    3ef7:	ff                   	(bad)  
    3ef8:	ff                   	(bad)  
    3ef9:	ff                   	(bad)  
    3efa:	ff                   	(bad)  
    3efb:	ff                   	(bad)  
    3efc:	ff                   	(bad)  
    3efd:	ff                   	(bad)  
    3efe:	ff                   	(bad)  
    3eff:	ff                   	(bad)  
    3f00:	ff                   	(bad)  
    3f01:	ff                   	(bad)  
    3f02:	ff                   	(bad)  
    3f03:	ff                   	(bad)  
    3f04:	ff                   	(bad)  
    3f05:	ff                   	(bad)  
    3f06:	ff                   	(bad)  
    3f07:	ff                   	(bad)  
    3f08:	ff                   	(bad)  
    3f09:	ff                   	(bad)  
    3f0a:	ff                   	(bad)  
    3f0b:	ff                   	(bad)  
    3f0c:	ff                   	(bad)  
    3f0d:	ff                   	(bad)  
    3f0e:	ff                   	(bad)  
    3f0f:	ff                   	(bad)  
    3f10:	ff                   	(bad)  
    3f11:	ff                   	(bad)  
    3f12:	ff                   	(bad)  
    3f13:	ff                   	(bad)  
    3f14:	ff                   	(bad)  
    3f15:	ff                   	(bad)  
    3f16:	ff                   	(bad)  
    3f17:	ff                   	(bad)  
    3f18:	ff                   	(bad)  
    3f19:	ff                   	(bad)  
    3f1a:	ff                   	(bad)  
    3f1b:	ff                   	(bad)  
    3f1c:	ff                   	(bad)  
    3f1d:	ff                   	(bad)  
    3f1e:	ff                   	(bad)  
    3f1f:	ff                   	(bad)  
    3f20:	ff                   	(bad)  
    3f21:	ff                   	(bad)  
    3f22:	ff                   	(bad)  
    3f23:	ff                   	(bad)  
    3f24:	ff                   	(bad)  
    3f25:	ff                   	(bad)  
    3f26:	ff                   	(bad)  
    3f27:	ff                   	(bad)  
    3f28:	ff                   	(bad)  
    3f29:	ff                   	(bad)  
    3f2a:	ff                   	(bad)  
    3f2b:	ff                   	(bad)  
    3f2c:	ff                   	(bad)  
    3f2d:	ff                   	(bad)  
    3f2e:	ff                   	(bad)  
    3f2f:	ff                   	(bad)  
    3f30:	ff                   	(bad)  
    3f31:	ff                   	(bad)  
    3f32:	ff                   	(bad)  
    3f33:	ff                   	(bad)  
    3f34:	ff                   	(bad)  
    3f35:	ff                   	(bad)  
    3f36:	ff                   	(bad)  
    3f37:	ff                   	(bad)  
    3f38:	ff                   	(bad)  
    3f39:	ff                   	(bad)  
    3f3a:	ff                   	(bad)  
    3f3b:	ff                   	(bad)  
    3f3c:	ff                   	(bad)  
    3f3d:	ff                   	(bad)  
    3f3e:	ff                   	(bad)  
    3f3f:	ff                   	(bad)  
    3f40:	ff                   	(bad)  
    3f41:	ff                   	(bad)  
    3f42:	ff                   	(bad)  
    3f43:	ff                   	(bad)  
    3f44:	ff                   	(bad)  
    3f45:	ff                   	(bad)  
    3f46:	ff                   	(bad)  
    3f47:	ff                   	(bad)  
    3f48:	ff                   	(bad)  
    3f49:	ff                   	(bad)  
    3f4a:	ff                   	(bad)  
    3f4b:	ff                   	(bad)  
    3f4c:	ff                   	(bad)  
    3f4d:	ff                   	(bad)  
    3f4e:	ff                   	(bad)  
    3f4f:	ff                   	(bad)  
    3f50:	ff                   	(bad)  
    3f51:	ff                   	(bad)  
    3f52:	ff                   	(bad)  
    3f53:	ff                   	(bad)  
    3f54:	ff                   	(bad)  
    3f55:	ff                   	(bad)  
    3f56:	ff                   	(bad)  
    3f57:	ff                   	(bad)  
    3f58:	ff                   	(bad)  
    3f59:	ff                   	(bad)  
    3f5a:	ff                   	(bad)  
    3f5b:	ff                   	(bad)  
    3f5c:	ff                   	(bad)  
    3f5d:	ff                   	(bad)  
    3f5e:	ff                   	(bad)  
    3f5f:	ff                   	(bad)  
    3f60:	ff                   	(bad)  
    3f61:	ff                   	(bad)  
    3f62:	ff                   	(bad)  
    3f63:	ff                   	(bad)  
    3f64:	ff                   	(bad)  
    3f65:	ff                   	(bad)  
    3f66:	ff                   	(bad)  
    3f67:	ff                   	(bad)  
    3f68:	ff                   	(bad)  
    3f69:	ff                   	(bad)  
    3f6a:	ff                   	(bad)  
    3f6b:	ff                   	(bad)  
    3f6c:	ff                   	(bad)  
    3f6d:	ff                   	(bad)  
    3f6e:	ff                   	(bad)  
    3f6f:	ff                   	(bad)  
    3f70:	ff                   	(bad)  
    3f71:	ff                   	(bad)  
    3f72:	ff                   	(bad)  
    3f73:	ff                   	(bad)  
    3f74:	ff                   	(bad)  
    3f75:	ff                   	(bad)  
    3f76:	ff                   	(bad)  
    3f77:	ff                   	(bad)  
    3f78:	ff                   	(bad)  
    3f79:	ff                   	(bad)  
    3f7a:	ff                   	(bad)  
    3f7b:	ff                   	(bad)  
    3f7c:	ff                   	(bad)  
    3f7d:	ff                   	(bad)  
    3f7e:	ff                   	(bad)  
    3f7f:	ff                   	(bad)  
    3f80:	ff                   	(bad)  
    3f81:	ff                   	(bad)  
    3f82:	ff                   	(bad)  
    3f83:	ff                   	(bad)  
    3f84:	ff                   	(bad)  
    3f85:	ff                   	(bad)  
    3f86:	ff                   	(bad)  
    3f87:	ff                   	(bad)  
    3f88:	ff                   	(bad)  
    3f89:	ff                   	(bad)  
    3f8a:	ff                   	(bad)  
    3f8b:	ff                   	(bad)  
    3f8c:	ff                   	(bad)  
    3f8d:	ff                   	(bad)  
    3f8e:	ff                   	(bad)  
    3f8f:	ff                   	(bad)  
    3f90:	ff                   	(bad)  
    3f91:	ff                   	(bad)  
    3f92:	ff                   	(bad)  
    3f93:	ff                   	(bad)  
    3f94:	ff                   	(bad)  
    3f95:	ff                   	(bad)  
    3f96:	ff                   	(bad)  
    3f97:	ff                   	(bad)  
    3f98:	ff                   	(bad)  
    3f99:	ff                   	(bad)  
    3f9a:	ff                   	(bad)  
    3f9b:	ff                   	(bad)  
    3f9c:	ff                   	(bad)  
    3f9d:	ff                   	(bad)  
    3f9e:	ff                   	(bad)  
    3f9f:	ff                   	(bad)  
    3fa0:	ff                   	(bad)  
    3fa1:	ff                   	(bad)  
    3fa2:	ff                   	(bad)  
    3fa3:	ff                   	(bad)  
    3fa4:	ff                   	(bad)  
    3fa5:	ff                   	(bad)  
    3fa6:	ff                   	(bad)  
    3fa7:	ff                   	(bad)  
    3fa8:	ff                   	(bad)  
    3fa9:	ff                   	(bad)  
    3faa:	ff                   	(bad)  
    3fab:	ff                   	(bad)  
    3fac:	ff                   	(bad)  
    3fad:	ff                   	(bad)  
    3fae:	ff                   	(bad)  
    3faf:	ff                   	(bad)  
    3fb0:	ff                   	(bad)  
    3fb1:	ff                   	(bad)  
    3fb2:	ff                   	(bad)  
    3fb3:	ff                   	(bad)  
    3fb4:	ff                   	(bad)  
    3fb5:	ff                   	(bad)  
    3fb6:	ff                   	(bad)  
    3fb7:	ff                   	(bad)  
    3fb8:	ff                   	(bad)  
    3fb9:	ff                   	(bad)  
    3fba:	ff                   	(bad)  
    3fbb:	ff                   	(bad)  
    3fbc:	ff                   	(bad)  
    3fbd:	ff                   	(bad)  
    3fbe:	ff                   	(bad)  
    3fbf:	ff                   	(bad)  
    3fc0:	ff                   	(bad)  
    3fc1:	ff                   	(bad)  
    3fc2:	ff                   	(bad)  
    3fc3:	ff                   	(bad)  
    3fc4:	ff                   	(bad)  
    3fc5:	ff                   	(bad)  
    3fc6:	ff                   	(bad)  
    3fc7:	ff                   	(bad)  
    3fc8:	ff                   	(bad)  
    3fc9:	ff                   	(bad)  
    3fca:	ff                   	(bad)  
    3fcb:	ff                   	(bad)  
    3fcc:	ff                   	(bad)  
    3fcd:	ff                   	(bad)  
    3fce:	ff                   	(bad)  
    3fcf:	ff                   	(bad)  
    3fd0:	ff                   	(bad)  
    3fd1:	ff                   	(bad)  
    3fd2:	ff                   	(bad)  
    3fd3:	ff                   	(bad)  
    3fd4:	ff                   	(bad)  
    3fd5:	ff                   	(bad)  
    3fd6:	ff                   	(bad)  
    3fd7:	ff                   	(bad)  
    3fd8:	ff                   	(bad)  
    3fd9:	ff                   	(bad)  
    3fda:	ff                   	(bad)  
    3fdb:	ff                   	(bad)  
    3fdc:	ff                   	(bad)  
    3fdd:	ff                   	(bad)  
    3fde:	ff                   	(bad)  
    3fdf:	ff                   	(bad)  
    3fe0:	ff                   	(bad)  
    3fe1:	ff                   	(bad)  
    3fe2:	ff                   	(bad)  
    3fe3:	ff                   	(bad)  
    3fe4:	ff                   	(bad)  
    3fe5:	ff                   	(bad)  
    3fe6:	ff                   	(bad)  
    3fe7:	ff                   	(bad)  
    3fe8:	ff                   	(bad)  
    3fe9:	ff                   	(bad)  
    3fea:	ff                   	(bad)  
    3feb:	ff                   	(bad)  
    3fec:	ff                   	(bad)  
    3fed:	ff                   	(bad)  
    3fee:	ff                   	(bad)  
    3fef:	ff                   	(bad)  
    3ff0:	ea aa 1a 10 fd       	ljmp   $0xfd10,$0x1aaa
    3ff5:	ff 01                	incw   (%bx,%di)
    3ff7:	ff 00                	incw   (%bx,%si)
    3ff9:	00 00                	add    %al,(%bx,%si)
    3ffb:	00 ff                	add    %bh,%bh
    3ffd:	ff                   	(bad)  
    3ffe:	ff                   	(bad)  
    3fff:	ff                   	.byte 0xff
