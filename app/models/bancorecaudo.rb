class Bancorecaudo < ActiveRecord::Base

  def self.search(search,searchn,search0, page)
    logger.error("Dentro del search..."+search.to_s+"--")
    logger.error("Dentro del searchn..."+searchn.to_s+"--")
    logger.error("Dentro del search0..."+search0.to_s+"--")
    if search.to_s == nil and searchn.to_s == nil and search0.to_s == nil
      paginate :per_page => 40, :page => page, :conditions => ["nro_obligacion = '-1'"]
    else
      if search.to_s != ""
        paginate :per_page => 40, :page => page, :conditions => ["consecutivo = #{search.to_s.strip}"], :order=>'nro_obligacion'
      elsif search0.to_s != ""
        paginate :per_page => 40, :page => page, :conditions => ["nro_obligacion = #{search0.to_s.strip}"], :order=>'nro_obligacion'
      elsif searchn.to_s != ""
        paginate :per_page => 40, :page => page, :conditions => ["to_char(fecha,'YYYY-MM-DD') = '#{searchn}'"], :order=>'nro_obligacion'
      else
        paginate :per_page => 40, :page => page, :conditions => ["nro_obligacion = '-1'"]
      end
    end
  end


end
