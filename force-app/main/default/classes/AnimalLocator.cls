public class AnimalLocator {
	public static String getAnimalNameById(Integer id) {
    	Http http = new Http();
        String animalName = '';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animalData = (Map<String, Object>)result.get('animal');
			System.debug(animalData.get('id'));
            if(animalData.get('id') != 0){
                animalName = (String)animalData.get('name');
            }
			
            // Cast the values in the 'animals' key as a list
            //List<Object> animals = (List<Object>) results.get('animals');
            //System.debug('Received the following animals:');
            //for (Object animal: animals) {
                //System.debug(animal);
            //}
        }
        return animalName;
        //return response;
    }
}