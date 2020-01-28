public class ParkLocator {
	public static List<String> country(String countryName) {
        ParkService.ParksImplPort park = new  ParkService.ParksImplPort();
        return park.byCountry(countryName);
    }
}