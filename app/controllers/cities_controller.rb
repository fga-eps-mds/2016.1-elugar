class CitiesController < ApplicationController
  def index
    
  end

  def show_cities
    sorted_cities = params[:sort_cities]
  	if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%")
      case sorted_cities
        when "Populacao"
          @cities = @cities.sort_by{|obj| obj.population}.reverse
        when "Densidade"
          @cities = @cities.sort_by{|obj| obj.demographic_density}.reverse
        when "Area"
          @cities = @cities.sort_by{|obj| obj.area}.reverse
        when "Frota"
          @cities = @cities.sort_by{|obj| obj.fleet}.reverse
        when "IDH"
          @cities = @cities.sort_by{|obj| obj.idh}.reverse
        when "Gini"
          @cities = @cities.sort_by {|obj| obj.gini}.reverse
        when "Saude"
          @cities = @cities.sort_by{|obj| obj.health}.reverse
        else
  		    @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
      end
    else
  	  @cities = City.all
      @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	end
  end

  def show
    get_hash
    @oldID = params[:id]
    @city = City.find(@oldID)
  end

  def compare
    get_hash
    if(params[:id])
      @oldID = params[:id]
      @city1 = City.find(@oldID)
    end
    if(params[:newID])
      @newID = params[:newID]
      @city2 = City.find(@newID)
      @population = @city1.population*100/(@city1.population + @city2.population)
    end
    if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
    else
      @cities = City.all.sort{ |a,b| a.name.downcase <=> b.name.downcase }
    end
  end

  def get_hash
    @hash = Hash.new
    @hash['name'] = 'Nome'
    @hash['population'] = 'População Estimada 2015'
    @hash['demographic_density'] = 'Densidade Demográfica'
    @hash['area'] = 'Tamanho da Cidade'
    @hash['fleet'] = 'Transporte'
    @hash['idh'] = 'IDH'
    @hash['gini'] = 'Índice de Gini'
    @hash['health'] = 'Índice de Saúde'
    @hash['violence'] = 'Índice de Violência'
    @hash['uber'] = 'Uber'
  end
end
