open Prims
let disentangle_abbrevs_from_bundle:
  FStar_Syntax_Syntax.sigelt Prims.list ->
    FStar_Syntax_Syntax.qualifier Prims.list ->
      FStar_Ident.lident Prims.list ->
        FStar_Range.range ->
          (FStar_Syntax_Syntax.sigelt* FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun sigelts  ->
    fun quals  ->
      fun members  ->
        fun rng  ->
          let type_abbrev_sigelts =
            FStar_All.pipe_right sigelts
              (FStar_List.collect
                 (fun x  ->
                    match x.FStar_Syntax_Syntax.sigel with
                    | FStar_Syntax_Syntax.Sig_let
                        ((false
                          ,{
                             FStar_Syntax_Syntax.lbname = FStar_Util.Inr
                               uu____31;
                             FStar_Syntax_Syntax.lbunivs = uu____32;
                             FStar_Syntax_Syntax.lbtyp = uu____33;
                             FStar_Syntax_Syntax.lbeff = uu____34;
                             FStar_Syntax_Syntax.lbdef = uu____35;_}::[]),uu____36,uu____37)
                        -> [x]
                    | FStar_Syntax_Syntax.Sig_let
                        (uu____51,uu____52,uu____53) ->
                        failwith
                          "mutrecty: disentangle_abbrevs_from_bundle: type_abbrev_sigelts: impossible"
                    | uu____59 -> [])) in
          match type_abbrev_sigelts with
          | [] ->
              ({
                 FStar_Syntax_Syntax.sigel =
                   (FStar_Syntax_Syntax.Sig_bundle (sigelts, members));
                 FStar_Syntax_Syntax.sigrng = rng;
                 FStar_Syntax_Syntax.sigquals = quals;
                 FStar_Syntax_Syntax.sigmeta =
                   FStar_Syntax_Syntax.default_sigmeta
               }, [])
          | uu____66 ->
              let type_abbrevs =
                FStar_All.pipe_right type_abbrev_sigelts
                  (FStar_List.map
                     (fun x  ->
                        match x.FStar_Syntax_Syntax.sigel with
                        | FStar_Syntax_Syntax.Sig_let
                            ((uu____73,{
                                         FStar_Syntax_Syntax.lbname =
                                           FStar_Util.Inr fv;
                                         FStar_Syntax_Syntax.lbunivs =
                                           uu____75;
                                         FStar_Syntax_Syntax.lbtyp = uu____76;
                                         FStar_Syntax_Syntax.lbeff = uu____77;
                                         FStar_Syntax_Syntax.lbdef = uu____78;_}::[]),uu____79,uu____80)
                            ->
                            (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                        | uu____94 ->
                            failwith
                              "mutrecty: disentangle_abbrevs_from_bundle: type_abbrevs: impossible")) in
              let unfolded_type_abbrevs =
                let rev_unfolded_type_abbrevs = FStar_Util.mk_ref [] in
                let in_progress = FStar_Util.mk_ref [] in
                let not_unfolded_yet = FStar_Util.mk_ref type_abbrev_sigelts in
                let remove_not_unfolded lid =
                  let uu____116 =
                    let uu____118 = FStar_ST.read not_unfolded_yet in
                    FStar_All.pipe_right uu____118
                      (FStar_List.filter
                         (fun x  ->
                            match x.FStar_Syntax_Syntax.sigel with
                            | FStar_Syntax_Syntax.Sig_let
                                ((uu____126,{
                                              FStar_Syntax_Syntax.lbname =
                                                FStar_Util.Inr fv;
                                              FStar_Syntax_Syntax.lbunivs =
                                                uu____128;
                                              FStar_Syntax_Syntax.lbtyp =
                                                uu____129;
                                              FStar_Syntax_Syntax.lbeff =
                                                uu____130;
                                              FStar_Syntax_Syntax.lbdef =
                                                uu____131;_}::[]),uu____132,uu____133)
                                ->
                                Prims.op_Negation
                                  (FStar_Ident.lid_equals lid
                                     (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v)
                            | uu____147 -> true)) in
                  FStar_ST.write not_unfolded_yet uu____116 in
                let rec unfold_abbrev_fv t fv =
                  let replacee x =
                    match x.FStar_Syntax_Syntax.sigel with
                    | FStar_Syntax_Syntax.Sig_let
                        ((uu____167,{
                                      FStar_Syntax_Syntax.lbname =
                                        FStar_Util.Inr fv';
                                      FStar_Syntax_Syntax.lbunivs = uu____169;
                                      FStar_Syntax_Syntax.lbtyp = uu____170;
                                      FStar_Syntax_Syntax.lbeff = uu____171;
                                      FStar_Syntax_Syntax.lbdef = uu____172;_}::[]),uu____173,uu____174)
                        when
                        FStar_Ident.lid_equals
                          (fv'.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                        -> Some x
                    | uu____188 -> None in
                  let replacee_term x =
                    match replacee x with
                    | Some
                        {
                          FStar_Syntax_Syntax.sigel =
                            FStar_Syntax_Syntax.Sig_let
                            ((uu____199,{
                                          FStar_Syntax_Syntax.lbname =
                                            uu____200;
                                          FStar_Syntax_Syntax.lbunivs =
                                            uu____201;
                                          FStar_Syntax_Syntax.lbtyp =
                                            uu____202;
                                          FStar_Syntax_Syntax.lbeff =
                                            uu____203;
                                          FStar_Syntax_Syntax.lbdef = tm;_}::[]),uu____205,uu____206);
                          FStar_Syntax_Syntax.sigrng = uu____207;
                          FStar_Syntax_Syntax.sigquals = uu____208;
                          FStar_Syntax_Syntax.sigmeta = uu____209;_}
                        -> Some tm
                    | uu____228 -> None in
                  let uu____232 =
                    let uu____236 = FStar_ST.read rev_unfolded_type_abbrevs in
                    FStar_Util.find_map uu____236 replacee_term in
                  match uu____232 with
                  | Some x -> x
                  | None  ->
                      let uu____250 =
                        FStar_Util.find_map type_abbrev_sigelts replacee in
                      (match uu____250 with
                       | Some se ->
                           let uu____253 =
                             let uu____254 = FStar_ST.read in_progress in
                             FStar_List.existsb
                               (fun x  ->
                                  FStar_Ident.lid_equals x
                                    (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v)
                               uu____254 in
                           if uu____253
                           then
                             let msg =
                               FStar_Util.format1
                                 "Cycle on %s in mutually recursive type abbreviations"
                                 ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str in
                             raise
                               (FStar_Errors.Error
                                  (msg,
                                    (FStar_Ident.range_of_lid
                                       (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v)))
                           else unfold_abbrev se
                       | uu____262 -> t)
                and unfold_abbrev x =
                  match x.FStar_Syntax_Syntax.sigel with
                  | FStar_Syntax_Syntax.Sig_let
                      ((false ,lb::[]),uu____266,attr) ->
                      let quals1 =
                        FStar_All.pipe_right x.FStar_Syntax_Syntax.sigquals
                          (FStar_List.filter
                             (fun uu___179_280  ->
                                match uu___179_280 with
                                | FStar_Syntax_Syntax.Noeq  -> false
                                | uu____281 -> true)) in
                      let lid =
                        match lb.FStar_Syntax_Syntax.lbname with
                        | FStar_Util.Inr fv ->
                            (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                        | uu____284 ->
                            failwith
                              "mutrecty: disentangle_abbrevs_from_bundle: rename_abbrev: lid: impossible" in
                      ((let uu____288 =
                          let uu____290 = FStar_ST.read in_progress in lid ::
                            uu____290 in
                        FStar_ST.write in_progress uu____288);
                       (match () with
                        | () ->
                            (remove_not_unfolded lid;
                             (match () with
                              | () ->
                                  let ty' =
                                    FStar_Syntax_InstFV.inst unfold_abbrev_fv
                                      lb.FStar_Syntax_Syntax.lbtyp in
                                  let tm' =
                                    FStar_Syntax_InstFV.inst unfold_abbrev_fv
                                      lb.FStar_Syntax_Syntax.lbdef in
                                  let lb' =
                                    let uu___180_302 = lb in
                                    {
                                      FStar_Syntax_Syntax.lbname =
                                        (uu___180_302.FStar_Syntax_Syntax.lbname);
                                      FStar_Syntax_Syntax.lbunivs =
                                        (uu___180_302.FStar_Syntax_Syntax.lbunivs);
                                      FStar_Syntax_Syntax.lbtyp = ty';
                                      FStar_Syntax_Syntax.lbeff =
                                        (uu___180_302.FStar_Syntax_Syntax.lbeff);
                                      FStar_Syntax_Syntax.lbdef = tm'
                                    } in
                                  let sigelt' =
                                    FStar_Syntax_Syntax.Sig_let
                                      ((false, [lb']), [lid], attr) in
                                  ((let uu____311 =
                                      let uu____313 =
                                        FStar_ST.read
                                          rev_unfolded_type_abbrevs in
                                      (let uu___181_318 = x in
                                       {
                                         FStar_Syntax_Syntax.sigel = sigelt';
                                         FStar_Syntax_Syntax.sigrng =
                                           (uu___181_318.FStar_Syntax_Syntax.sigrng);
                                         FStar_Syntax_Syntax.sigquals =
                                           quals1;
                                         FStar_Syntax_Syntax.sigmeta =
                                           (uu___181_318.FStar_Syntax_Syntax.sigmeta)
                                       }) :: uu____313 in
                                    FStar_ST.write rev_unfolded_type_abbrevs
                                      uu____311);
                                   (match () with
                                    | () ->
                                        ((let uu____323 =
                                            let uu____325 =
                                              FStar_ST.read in_progress in
                                            FStar_List.tl uu____325 in
                                          FStar_ST.write in_progress
                                            uu____323);
                                         (match () with | () -> tm'))))))))
                  | uu____333 ->
                      failwith
                        "mutrecty: disentangle_abbrevs_from_bundle: rename_abbrev: impossible" in
                let rec aux uu____338 =
                  let uu____339 = FStar_ST.read not_unfolded_yet in
                  match uu____339 with
                  | x::uu____346 -> let _unused = unfold_abbrev x in aux ()
                  | uu____349 ->
                      let uu____351 = FStar_ST.read rev_unfolded_type_abbrevs in
                      FStar_List.rev uu____351 in
                aux () in
              let filter_out_type_abbrevs l =
                FStar_List.filter
                  (fun lid  ->
                     FStar_List.for_all
                       (fun lid'  ->
                          Prims.op_Negation (FStar_Ident.lid_equals lid lid'))
                       type_abbrevs) l in
              let inductives_with_abbrevs_unfolded =
                let find_in_unfolded fv =
                  FStar_Util.find_map unfolded_type_abbrevs
                    (fun x  ->
                       match x.FStar_Syntax_Syntax.sigel with
                       | FStar_Syntax_Syntax.Sig_let
                           ((uu____380,{
                                         FStar_Syntax_Syntax.lbname =
                                           FStar_Util.Inr fv';
                                         FStar_Syntax_Syntax.lbunivs =
                                           uu____382;
                                         FStar_Syntax_Syntax.lbtyp =
                                           uu____383;
                                         FStar_Syntax_Syntax.lbeff =
                                           uu____384;
                                         FStar_Syntax_Syntax.lbdef = tm;_}::[]),uu____386,uu____387)
                           when
                           FStar_Ident.lid_equals
                             (fv'.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                             (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                           -> Some tm
                       | uu____403 -> None) in
                let unfold_fv t fv =
                  let uu____413 = find_in_unfolded fv in
                  match uu____413 with | Some t' -> t' | uu____422 -> t in
                let unfold_in_sig x =
                  match x.FStar_Syntax_Syntax.sigel with
                  | FStar_Syntax_Syntax.Sig_inductive_typ
                      (lid,univs1,bnd,ty,mut,dc) ->
                      let bnd' =
                        FStar_Syntax_InstFV.inst_binders unfold_fv bnd in
                      let ty' = FStar_Syntax_InstFV.inst unfold_fv ty in
                      let mut' = filter_out_type_abbrevs mut in
                      [(let uu___182_446 = x in
                        {
                          FStar_Syntax_Syntax.sigel =
                            (FStar_Syntax_Syntax.Sig_inductive_typ
                               (lid, univs1, bnd', ty', mut', dc));
                          FStar_Syntax_Syntax.sigrng =
                            (uu___182_446.FStar_Syntax_Syntax.sigrng);
                          FStar_Syntax_Syntax.sigquals =
                            (uu___182_446.FStar_Syntax_Syntax.sigquals);
                          FStar_Syntax_Syntax.sigmeta =
                            (uu___182_446.FStar_Syntax_Syntax.sigmeta)
                        })]
                  | FStar_Syntax_Syntax.Sig_datacon
                      (lid,univs1,ty,res,npars,mut) ->
                      let ty' = FStar_Syntax_InstFV.inst unfold_fv ty in
                      let mut' = filter_out_type_abbrevs mut in
                      [(let uu___183_460 = x in
                        {
                          FStar_Syntax_Syntax.sigel =
                            (FStar_Syntax_Syntax.Sig_datacon
                               (lid, univs1, ty', res, npars, mut'));
                          FStar_Syntax_Syntax.sigrng =
                            (uu___183_460.FStar_Syntax_Syntax.sigrng);
                          FStar_Syntax_Syntax.sigquals =
                            (uu___183_460.FStar_Syntax_Syntax.sigquals);
                          FStar_Syntax_Syntax.sigmeta =
                            (uu___183_460.FStar_Syntax_Syntax.sigmeta)
                        })]
                  | FStar_Syntax_Syntax.Sig_let
                      (uu____462,uu____463,uu____464) -> []
                  | uu____469 ->
                      failwith
                        "mutrecty: inductives_with_abbrevs_unfolded: unfold_in_sig: impossible" in
                FStar_List.collect unfold_in_sig sigelts in
              let new_members = filter_out_type_abbrevs members in
              let new_bundle =
                {
                  FStar_Syntax_Syntax.sigel =
                    (FStar_Syntax_Syntax.Sig_bundle
                       (inductives_with_abbrevs_unfolded, new_members));
                  FStar_Syntax_Syntax.sigrng = rng;
                  FStar_Syntax_Syntax.sigquals = quals;
                  FStar_Syntax_Syntax.sigmeta =
                    FStar_Syntax_Syntax.default_sigmeta
                } in
              (new_bundle, unfolded_type_abbrevs)