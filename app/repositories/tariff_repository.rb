class TariffRepository < ROM::Repository::Root
  root :tariffs

  auto_struct false
  struct_namespace Rapi::Entities

  def find(id)
    tariffs.by_id(id).one
  end

  def all
    tariffs.to_a
  end

  private

  def tariffs
    super.map_with(:tariffs_mapper)
  end
end
