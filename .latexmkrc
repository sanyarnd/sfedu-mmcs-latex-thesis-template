$pdf_mode = 5;      # XeLaTeX
$bibtex_use = 2;    # biber
set_tex_cmds('-synctex=1 -file-line-error %O %S');
@default_files = ('diploma.tex');
push @generated_exts, 'run.xml', 'bcf', 'nav', 'snm', 'vrb', 'synctex.gz', 'xdv';
