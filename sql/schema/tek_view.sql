create view tek_complete as
    select 
        concat(p.grade, '.', p.section, t.alpha) as tek,
        p.grade,
        t.standard,
        p.content as 'ks',
        t.content as 'se'
        from tek t, tek_parent p 
        where 
        t.tek_parent_id=p.id
        order by p.grade, p.section, t.alpha;