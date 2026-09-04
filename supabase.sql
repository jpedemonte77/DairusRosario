-- ============================================================
--  CARTA DE DAIRUS — carga completa
--  Transcripción de las 5 páginas de la carta impresa.
--
--  CÓMO USARLO
--  1. Si querés poner los precios ahora: reemplazá cada `null`
--     por el número, sin símbolo ni puntos.  Ej:  null  →  4500
--     (los que dejes en null quedan sin precio y los completás
--     después desde el panel).
--  2. Pegá todo el archivo en Supabase → SQL Editor → Run.
--
--  ⚠️  BORRA las secciones y productos que hay ahora (incluidos
--      los de ejemplo) y carga esta carta de cero.
-- ============================================================

begin;

delete from public.products;
delete from public.categories;

-- ------------------------------------------------------------
-- 1. CAFETERÍA
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Cafetería', '', 1, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Espresso',                'Shot de café',                                 null::numeric, 1),
  ('Americano',               'Doble shot de café, agua caliente',            null, 2),
  ('Pocillo',                 'Americano, cortado, lágrima',                  null, 3),
  ('Jarrita',                 'Americano, cortado, lágrima',                  null, 4),
  ('Latte / Café con leche',  'Shot de café, leche texturizada',              null, 5),
  ('Lágrima doble',           'Leche texturizada, ½ shot de café',            null, 6),
  ('Flat White / Cortado doble', 'Doble shot de café, leche texturizada',     null, 7),
  ('Té / Mate cocido',        'Con o sin leche',                              null, 8),
  ('Remo',                    'Leche texturizada, barrita de chocolate',      null, 9)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 2. CHOCOLATERÍA
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Chocolatería', '', 2, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Chocolate negro / blanco caliente', 'Leche texturizada, café, cacao y canela', null::numeric, 1),
  ('Choco Nutella',    'Shot de café, ½ syrup pistacho, leche texturizada',   null, 2),
  ('Choco Surprise',   'Leche caliente, vaso de chocolate relleno con malvaviscos, cacao, postre de chocolate, algún tipo de fruto seco picado', null, 3),
  ('Afogatto coffe',   'Bocha de helado americana, 1 shot de café',           null, 4),
  ('Afogatto choco',   'Bocha de helado americana, choco caliente',           null, 5)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 3. ICED COFFE
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Iced Coffe', '', 3, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Iced Latte',             'Shot de espresso, leche / hielo',                          null::numeric, 1),
  ('Iced Flat White',        'Doble shot de espresso, leche / hielo',                    null, 2),
  ('Iced Americano',         'Doble shot de espresso, agua / hielo',                     null, 3),
  ('Iced Caramel Machiatto', 'Shot de espresso, ¼ oz syrup de caramelo, leche / hielo',  null, 4),
  ('Iced pistacho',          'Shot de espresso, ½ oz syrup pistacho, leche / hielo',     null, 5)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 4. SANDWICH CALIENTE
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Sandwich caliente', '', 4, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Carlitos / Tostado',  '',                                          null::numeric, 1),
  ('Carlitos Pollo',      '',                                          null, 2),
  ('Carlitos Especial',   '',                                          null, 3),
  ('Calentito',           'Pan de campo, manteca, jamón y queso',      null, 4),
  ('Dairus',              'Carne vacuna desmechada a las finas hierbas c/cebolla y queso gratinado, en pan de lomo c/semillas', null, 5)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 5. SANDWICH FRÍOS
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Sandwich fríos', 'Pan de campo', 5, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Primavera',   '', null::numeric, 1),
  ('Atún',        '', null, 2),
  ('Pollo',       '', null, 3),
  ('Vegetariano', '', null, 4)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 6. FOCACCIA
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Focaccia', '', 6, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Mediterránea', 'Jamón crudo, queso Pategrás, rúcula, tomates cherrys, lluvia de parmesano c/manteca y oliva', null::numeric, 1),
  ('Campo',        'Salamín picado grueso y queso Pategrás c/manteca',        null, 2),
  ('Amor',         'Mortadela c/pistacho, queso Pategrás c/manteca',          null, 3),
  ('Romántica',    'Escabeche de verduras, queso Tybo c/manteca',             null, 4)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 7. CROISSANT
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Croissant', '', 7, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Lima Key',        '', null::numeric, 1),
  ('Nutella',         '', null, 2),
  ('Tiramisú',        '', null, 3),
  ('Pastelera',       '', null, 4),
  ('Dulce de leche',  '', null, 5),
  ('Dubai',           'Queso crema, aceite de hierbas, tomates cherrys y pepinos', null, 6),
  ('Salada',          '', null, 7)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 8. WAFFLES
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Waffles', '', 8, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Dulce de leche y banana', '', null::numeric, 1),
  ('Frutilla y chantilly',    '', null, 2),
  ('Helado americana, frutos rojos y salsa de caramelo', '', null, 3),
  ('Choco Oreo',              '', null, 4)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 9. TORTAS INDIVIDUALES
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Tortas individuales', '', 9, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, v.note, v.ord, true from c, (values
  ('Chocotorta - Choco Oreo', '',                                                     null::numeric, '',        1),
  ('Brownie',                 'Dulce de leche, chantilly o merengue y frutas o golosinas', null, '',        2),
  ('Oreo - Cheese Cake',      'Consultar variedad disponible',                        null, '',        3),
  ('Lima Key',                '',                                                     null, '',        4),
  ('Tiramisú',                '',                                                     null, '',        5),
  ('Selva negra',             '',                                                     null, 'lingote', 6),
  ('Red Velvet',              '',                                                     null, 'lingote', 7),
  ('Tres chocolates',         '',                                                     null, '',        8)
) as v(name, descr, price, note, ord);

-- ------------------------------------------------------------
-- 10. TORTA PORCIONES
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Torta porciones', '', 10, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Ricota',                     '', null::numeric, 1),
  ('Manzana',                    '', null, 2),
  ('Lemon Pie',                  '', null, 3),
  ('Matilda',                    '', null, 4),
  ('Brownie Ferrero',            '', null, 5),
  ('Brownie Pistachio',          '', null, 6),
  ('Budín de limón y arándanos', '', null, 7),
  ('Budín carrot cake',          '', null, 8)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 11. COOKIES
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Cookies', '', 11, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Brownie',              '', null::numeric, 1),
  ('Red Velvet',           '', null, 2),
  ('Chispitas / Rockets',  '', null, 3),
  ('Limón y amapolas',     '', null, 4)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 12. DONAS
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Donas', '', 12, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Clásicas',                 '',                             null::numeric, 1),
  ('Rellenas de dulce de leche', '',                           null, 2),
  ('Coron',                    'Frutillas y chantilly',        null, 3),
  ('Dairus',                   'Rellena con Nutella, baño de chocolate con cubos de brownie y Ferrero en el centro', null, 4),
  ('Pista',                    'Bañada con choco saborizado, rellena con crema de pistachio y lluvia de pistachio',  null, 5)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 13. FRITOS
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Fritos', '', 13, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Churros',            '',                                    null::numeric, 1),
  ('Churros rellenos',   'Dulce de leche o pastelera',          null, 2),
  ('Minis',              'Mini churros con tres dips: dulce de leche, pastelera y Nutella. Opcional con almíbar', null, 3),
  ('Pastelitos criollos','',                                    null, 4),
  ('Tortas fritas',      '',                                    null, 5)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 14. PANADERÍA
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Panadería', '', 14, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Medias lunas, facturas, bizcochos', '', null::numeric, 1),
  ('Rolls de canela',                   '', null, 2),
  ('Turcas',                            '', null, 3),
  ('Turcas de choco y naranja',         '', null, 4),
  ('Chipá',                             '', null, 5),
  ('Chocolatoso',                       '', null, 6)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 15. BRUNCH
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Brunch', 'Para 2 personas', 15, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, v.note, v.ord, true from c, (values
  ('Brunch Dairus',
   '2 alfajorcitos de maicena, 1 brownie, 1 cheese cake, 1 dona rústica, 2 chipá, 1 focaccia a elección, 2 tazones y 2 vasos de limonada o jugo',
   null::numeric, 'para 2', 1)
) as v(name, descr, price, note, ord);

-- ------------------------------------------------------------
-- 16. DESAYUNOS
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Desayunos', '', 16, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, '', v.ord, true from c, (values
  ('Clásico',   'Infusión con 2 medias lunas / facturas',                                                          null::numeric, 1),
  ('Tostadas',  'Infusión con 2 tostadas con mermelada y queso crema / dulce de leche / manteca',                  null, 2),
  ('Tostón',    'Infusión con 1 tostón con huevos revueltos, 2 fetas de jamón cocido y 2 de queso, yogurt y granolas', null, 3),
  ('Avocado',   'Infusión con 2 huevos revueltos, palta, tomates cherry y semillas',                               null, 4),
  ('Rosarino',  'Infusión con ½ tostado / carlito',                                                                null, 5),
  ('Proteico',  'Infusión con un tostón, 2 huevos revueltos, 2 fetas de panceta a la plancha, 2 fetas de queso, mix de frutos secos', null, 6),
  ('Saludable', 'Yogurt con granolas, frutas, dips de miel, exprimido / licuado',                                  null, 7),
  ('Campestre', 'Infusión en tazón de 750 cc de café filtrado, pan flauta c/manteca y rodajas de salamín, jugo exprimido', null, 8)
) as v(name, descr, price, ord);

-- ------------------------------------------------------------
-- 17. BEBIDAS SIN ALCOHOL
-- ------------------------------------------------------------
with c as (
  insert into public.categories (name, description, sort_order, visible)
  values ('Bebidas sin alcohol', '', 17, true) returning id
)
insert into public.products (category_id, name, description, price, price_note, sort_order, visible)
select c.id, v.name, v.descr, v.price, v.note, v.ord, true from c, (values
  ('Agua sin y con gas', '',                                                            null::numeric, '',     1),
  ('Gaseosas',           '',                                                            null, '',     2),
  ('Limonada',           'Jugo de limón, almíbar simple, soda, menta y jengibre',        null, '',     3),
  ('Limonada',           'Jugo de limón, almíbar simple, soda, menta y jengibre',        null, '1 lt', 4),
  ('Pomelada',           'Jugo de pomelo, almíbar simple, soda, menta y albahaca',       null, '',     5),
  ('Pomelada',           'Jugo de pomelo, almíbar simple, soda, menta y albahaca',       null, '1 lt', 6),
  ('Exprimido',          'Natural de naranja',                                           null, '',     7),
  ('Licuado con agua',   'Banana, frutilla, durazno',                                    null, '',     8),
  ('Licuado con leche',  'Banana, frutilla, durazno',                                    null, '',     9),
  ('Milkshake',          '',                                                             null, '',     10),
  ('Jarra Pinn''s',      'Pinn''s, hielo, seven up, frutillas, limón, naranja, arándanos y hoja de menta', null, '', 11)
) as v(name, descr, price, note, ord);

commit;


-- ============================================================
--  OPCIONAL — identidad del bar.
--  Descomentá sólo si querés pisar lo que ya cargaste en el panel.
-- ============================================================
--
-- update public.settings set
--   bar_name        = 'Dairus',
--   tagline         = 'Viví la experiencia',
--   accent          = '#2ab49c',
--   footer_text     = E'Rosario\n@dairus.rosario',
--   currency_symbol = '$'
-- where id = 1;
