package ma;

import java.util.ArrayList;
import java.util.List;
import kr.co.shineware.nlp.komoran.core.analyzer.Komoran;
import kr.co.shineware.util.common.model.Pair;

public class Analyzer
{
	
	public static Komoran komoran;
	
	public static void main(String[] args)
	{
		System.out.println("Test OK");
	}

	public static String[] analyze(String[] inputStr)
	{
		komoran = new Komoran("models-full/");
		
		String orgKeyword = new String();
		String keywordRole = new String();
		
		ArrayList<String> rtn = new ArrayList<>();
		
		for(int i=0; i < inputStr.length; i++)
		{
			@SuppressWarnings("unchecked")
			List<List<Pair<String,String>>> result = komoran.analyze(inputStr[i]);
			
			for(List<Pair<String,String>> eojeolResult : result)
			{
				for(Pair<String,String> wordMorph : eojeolResult)
				{
					orgKeyword = wordMorph.getFirst();
					keywordRole = wordMorph.getSecond();
					rtn.add(orgKeyword + "/" + keywordRole);
				}
			}
		}
		
		String[] place = rtn.toArray(new String[rtn.size()]);
		
		return place;
	}
}